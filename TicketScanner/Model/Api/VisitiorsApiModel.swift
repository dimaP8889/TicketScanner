//
//  VisitiorsApiModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.08.2021.
//

import Foundation

struct VisitiorsApiModel : Codable {
    
    let checkins : [Checkins]
}

extension VisitiorsApiModel {
    
    struct Checkins : Codable {
        
        enum CodingKeys : String, CodingKey {
            
            case ticketTypeUk = "ticketType_uk"
            case ticketTypeEn = "ticketType_en"
            case validationString, result, buyer, timestamp, expectedEvent
        }
        
        let ticketTypeUk: String?
        let ticketTypeEn: String?
        let validationString: String?
        let result: String
        let buyer: Buyer?
        let expectedEvent : ExpectedEvent?
        let timestamp: Int
        
        init(from decoder: Decoder) throws {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            if let ticketTypeUk = try? container.decode(String?.self, forKey: .ticketTypeUk) {
                self.ticketTypeUk = ticketTypeUk
            } else {
                self.ticketTypeUk = nil
            }
            
            if let ticketTypeEn = try? container.decode(String?.self, forKey: .ticketTypeEn) {
                self.ticketTypeEn = ticketTypeEn
            } else {
                self.ticketTypeEn = nil
            }
            
            if let validationString = try? container.decode(String?.self, forKey: .validationString) {
                self.validationString = validationString
            } else {
                self.validationString = nil
            }
            
            result = try container.decode(String.self, forKey: .result)
            if let buyer = try? container.decode(Buyer?.self, forKey: .buyer) {
                self.buyer = buyer
            } else {
                self.buyer = nil
            }
            
            if let expectedEvent = try? container.decode(ExpectedEvent?.self, forKey: .expectedEvent) {
                self.expectedEvent = expectedEvent
            } else {
                self.expectedEvent = nil
            }
            
            timestamp = try container.decode(Int.self, forKey: .timestamp)
        }
    }
}

extension VisitiorsApiModel.Checkins {
    
    var notActivated : FullTicketModel {
        
        let time = Date(timeIntervalSince1970: TimeInterval(timestamp / 1000))
        let main = TicketMainInfoModel(name: localStr("ticket.status.not_activated.name.placeholder"), time: time.stringFullTime, ticketNumber: validationString ?? "")
        
        let ticketType : String
        switch Defaults.shared.getCurrentLang() {
        case "en":
            ticketType = ticketTypeEn ?? ticketTypeUk ?? ""
        default:
            ticketType = ticketTypeUk ?? localStr("ticket.status.not_activated.name.placeholder")
        }
        
        return FullTicketModel(
            main: main,
            status: .invalidQR,
            secondary: TicketSecondaryInfoModel(
                type: ticketType,
                number: localStr("ticket.status.not_activated.tel.placeholder"),
                email: localStr("ticket.status.not_activated.email.placeholder")
            ),
            timeDouble: Double(timestamp)
        )
    }
}

extension VisitiorsApiModel {
    
    func sortByTime() -> [Int: VisitiorsApiModel] {
        
        var timeDictionary : [Int: [Checkins]] = [:]
        
        let checkins = self.checkins.sorted { $0.timestamp > $1.timestamp }
        
        for checkin in checkins {
            
            let seconds = checkin.timestamp / 1000
            let hour = seconds / 3600
            
            if let oldTime = timeDictionary[hour] {
                let newCheckin = oldTime + [checkin]
                timeDictionary[hour] = newCheckin
            } else {
                timeDictionary[hour] = [checkin]
            }
        }
        
        var returnDict : [Int: VisitiorsApiModel] = [:]
        timeDictionary.forEach {
            returnDict[$0.key] = VisitiorsApiModel(checkins: $0.value)
        }
        
        return returnDict
    }
    
    func adaptToFullTicketModel() -> [FullTicketModel] {
        
        return checkins.map { checkin in
            
            let name = checkin.buyer?.name ?? localStr("ticket.status.not_activated.name.placeholder")
            
            let time = Date(timeIntervalSince1970: TimeInterval(checkin.timestamp / 1000))
            let main = TicketMainInfoModel(name: name, time: time.stringFullTime, ticketNumber: checkin.validationString ?? "")
            
            let ticketType : String
            switch Defaults.shared.getCurrentLang() {
            case "en":
                ticketType = checkin.ticketTypeEn ?? checkin.ticketTypeUk ?? ""
            default:
                ticketType = checkin.ticketTypeUk ?? ""
            }
            
            let status : TicketStatus = {
                
                switch checkin.result {
                case "already_checked_in":
                    return .checkedIn(time: nil, date: nil)
                case "ticket_was_refunded":
                    return .refunded(time: nil)
                case "wrong_event":
                    guard let expectedEvent = checkin.expectedEvent else {
                        return .wrongEvent(name: ticketType, time: nil)
                    }
                    
                    let ticketType : String
                    switch Defaults.shared.getCurrentLang() {
                    case "en":
                        ticketType = expectedEvent.titleUk ?? ""
                    default:
                        ticketType = expectedEvent.titleEn ?? expectedEvent.titleUk ?? ""
                    }
                    
                    let time = Date(timeIntervalSince1970: TimeInterval(expectedEvent.startDateTime / 1000))
                    
                    return .wrongEvent(name: ticketType, time: time.stringDate)
                case "ok":
                    return .success
                case "ticket_is_not_preprint_activated", "ticket_orphaned",
                     "ticket_was_cancelled_from_guestlist", "not_found":
                    return .invalidQR
                default:
                    return .invalidQR
                }
            }()
            
            let num = checkin.buyer?.phone.securedNumber ?? localStr("ticket.status.not_activated.tel.placeholder")
            let email = checkin.buyer?.email.securedEmail ?? localStr("ticket.status.not_activated.email.placeholder")
            
            let secondary = TicketSecondaryInfoModel(type: ticketType, number: num, email: email)
            
            return FullTicketModel(main: main, status: status, secondary: secondary, timeDouble: Double(checkin.timestamp))
        }.compactMap { $0 }
    }
}

extension VisitiorsApiModel {
    
    struct Buyer : Codable {
        
        let name: String
        let phone: String
        let email: String
    }
    
    struct ExpectedEvent : Codable {
        
        enum CodingKeys : String, CodingKey {
            
            case titleUk = "title_uk"
            case titleEn = "title_en"
            case startDateTime = "start_date_time"
        }
        
        let titleUk: String?
        let titleEn: String?
        let startDateTime: Int
    }
}
