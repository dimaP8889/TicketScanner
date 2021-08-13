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
            case validationString, result, buyer, timestamp
        }
        
        let ticketTypeUk: String?
        let ticketTypeEn: String?
        let validationString: String?
        let result: String
        let buyer: Buyer?
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
            
            timestamp = try container.decode(Int.self, forKey: .timestamp)
        }
    }
}

extension VisitiorsApiModel {
    
    func adaptToFullTicketModel() -> [FullTicketModel] {
        
        return checkins.map { checkin in
            
            guard let buyer = checkin.buyer else { return nil }
            
            let time = Date(timeIntervalSince1970: TimeInterval(checkin.timestamp / 1000)).stringFullTime
            let main = TicketMainInfoModel(name: buyer.name, time: time, ticketNumber: checkin.validationString ?? "")
            
            let status : TicketStatus = {
                
                switch checkin.result {
                case "ok":
                    return .success
                default:
                    return .wrongEvent(name: "", time: "")
                }
            }()
            
            let ticketType : String
            switch Defaults.shared.getCurrentLang() {
            case "en":
                ticketType = checkin.ticketTypeEn ?? checkin.ticketTypeUk ?? ""
            default:
                ticketType = checkin.ticketTypeUk ?? ""
            }
            
            let secondary = TicketSecondaryInfoModel(type: ticketType, number: buyer.phone, email: buyer.email)
            
            return FullTicketModel(main: main, status: status, secondary: secondary)
        }.compactMap { $0 }
    }
}

extension VisitiorsApiModel {
    
    struct Buyer : Codable {
        
        let name: String
        let phone: String
        let email: String
    }
}
