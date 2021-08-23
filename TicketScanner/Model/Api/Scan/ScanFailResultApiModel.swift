//
//  ScanResultApiModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 26.07.2021.
//

import Foundation

struct ScanFailResultApiModel : Codable {
    
    #warning("Better make an enum")
    let response: String
    
    let successfulScanTimestamp: Int?
    let expectedEvent: Event?
    let ticket: Ticket?
}

// MARK: - Adapter
extension ScanFailResultApiModel {
    
    // This one is only for failure response from backend
    func adaptToAlert(number : String) -> AlertModel {
        
        guard let ticket = adaptToTicket(number: number)
        else {
            return AlertModel(time: Date.currentTime, alertType: .invalidQR)
        }
        
        switch response {
        case "already_checked_in":
            let checkedInTime : String = {
                guard let timeInt = successfulScanTimestamp else {
                    return ""
                }
                let time = Date(timeIntervalSince1970: TimeInterval(timeInt / 1000))
                return time.stringShortTime
            }()
            return AlertModel(time: Date().stringFullTime, alertType: .checkedIn(time: checkedInTime, ticket: ticket))
        case "ticket_was_refunded":
            return AlertModel(time: Date().stringFullTime, alertType: .refunded(ticket: ticket))
        case "wrong_event":
            return AlertModel(time: Date().stringFullTime, alertType: .wrongEvent(ticket: ticket))
        default:
            return AlertModel(time: Date.currentTime, alertType: .invalidQR)
        }
    }
    
    func adaptToTicket(number : String) -> FullTicketModel? {
        
        guard let ticket = ticket else {
            return nil
        }
        
        let title : String
        switch Defaults.shared.getCurrentLang() {
        case "en":
            title = expectedEvent?.titleEn ?? expectedEvent?.titleUk ?? ""
        default:
            title = expectedEvent?.titleUk ?? ""
        }
        let name = ticket.buyer?.name ?? localStr("ticket.status.not_activated.name.placeholder")
        let date = Date()
        
        let main = TicketMainInfoModel(name: name, time: date.stringFullTime, ticketNumber: number)
        
        let status : TicketStatus
        switch response {
        case "already_checked_in":
            guard let time = successfulScanTimestamp else {
                return nil
            }
            let date = Date(timeIntervalSince1970: TimeInterval(time / 1000))
            status = .checkedIn(time: date.stringFullTime, date: date.stringDate)
        case "ticket_was_refunded":
            #warning("TODO")
//            guard let time = expectedEvent?.startDateTime else {
//                return nil
//            }
//            let date = Date(timeIntervalSince1970: TimeInterval(time / 1000))
            status = .refunded(time: nil)
        case "wrong_event":
            guard let time = expectedEvent?.startDateTime else {
                return nil
            }
            let date = Date(timeIntervalSince1970: TimeInterval(time / 1000))
            status = .wrongEvent(name: title, time: date.stringDate)
        case "ticket_is_not_preprint_activated":
            status = .notActivated
        default:
            return nil
        }
        
        let ticketType : String
        switch Defaults.shared.getCurrentLang() {
        case "en":
            ticketType = ticket.ticketTypeEn ?? ticket.ticketTypeUk
        default:
            ticketType = ticket.ticketTypeUk
        }
        
        let number = ticket.buyer?.phone ?? localStr("ticket.status.not_activated.tel.placeholder")
        let email = ticket.buyer?.email ?? localStr("ticket.status.not_activated.email.placeholder")
        let secondary = TicketSecondaryInfoModel(type: ticketType, number: number, email: email)
        
        return FullTicketModel(main: main, status: status, secondary: secondary, timeDouble: date.timeIntervalSinceNow)
    }
}

extension ScanFailResultApiModel {
    
    struct Event : Codable {
        
        enum CodingKeys : String, CodingKey {
            
            case titleUk = "title_uk"
            case titleEn = "title_en"
            case startDateTime = "start_date_time"
        }
        
        let titleUk: String
        let titleEn: String?
        let startDateTime: Int
    }
}

extension ScanFailResultApiModel {
    
    struct Ticket : Codable {
        
        enum CodingKeys : String, CodingKey {
            
            case ticketTypeUk = "ticketType_uk"
            case ticketTypeEn = "ticketType_en"
            case buyer
        }
        
        let ticketTypeUk: String
        let ticketTypeEn: String?
        let buyer : Buyer?
    }
}

extension ScanFailResultApiModel.Ticket {
    
    struct Buyer : Codable {
        
        let name: String
        let phone: String
        let email: String
    }
}
