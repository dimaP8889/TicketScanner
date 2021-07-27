//
//  ScanResultApiModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 26.07.2021.
//

import Foundation

struct ScanFailResultApiModel : Codable {
    
      let response: String
      let successfulScanTimestamp: String?
      let expectedEvent: Event?
      let ticket: Ticket?
}

// MARK: - Adapter
extension ScanFailResultApiModel {
    
    var adaptToAlert : AlertModel {
        
        guard let time = successfulScanTimestamp,
              let ticket = adaptToTicket
        else {
            return AlertModel(time: Date().currentTime, alertType: .invalidQR)
        }
        
        switch response {
        case "already_checked_in":
            return AlertModel(time: time, alertType: .checkedIn(time: time, ticket: ticket))
        case "ticket_was_refunded":
            return AlertModel(time: time, alertType: .refunded(ticket: ticket))
        case "wrong_event":
            return AlertModel(time: time, alertType: .wrongEvent(ticket: ticket))
        default:
            return AlertModel(time: Date().currentTime, alertType: .invalidQR)
        }
    }
    
    var adaptToTicket : FullTicketModel? {
        
        guard let ticket = ticket,
              let event = expectedEvent,
              let time = successfulScanTimestamp
        else {
            return nil
        }
        
        let title : String
        switch Defaults.shared.getCurrentLang() {
        case "en":
            title = event.titleEn
        default:
            title = event.titleUk
        }
        
        #warning("No ticket number")
        #warning("Need time in since1970")
        let main = TicketMainInfoModel(name: event.titleUk, time: time, ticketNumber: "lolol")
        
        let status : TicketStatus
        switch response {
        case "already_checked_in":
            status = .checkedIn(time: time, date: time)
        case "ticket_was_refunded":
            status = .refunded(time: time)
        case "wrong_event":
            status = .wrongEvent(name: title, time: time)
        default:
            return nil
        }
        
        let ticketType : String
        switch Defaults.shared.getCurrentLang() {
        case "en":
            ticketType = ticket.ticketTypeEn
        default:
            ticketType = ticket.ticketTypeUk
        }
        
        let secondary = TicketSecondaryInfoModel(type: ticketType, number: ticket.buyer.phone, email: ticket.buyer.email)
        
        return FullTicketModel(main: main, status: status, secondary: secondary)
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
        let titleEn: String
        let startDateTime: String
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
        let ticketTypeEn: String
        let buyer : Buyer
    }
}

extension ScanFailResultApiModel.Ticket {
    
    struct Buyer : Codable {
        
        let name: String
        let phone: String
        let email: String
    }
}
