//
//  ScanResultApiModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 26.07.2021.
//

import Foundation

struct ScanResultApiModel : Codable {
    
      let response: String
      let successfulScanTimestamp: String?
      let expectedEvent: Event?
      let ticket: Ticket?
}

extension ScanResultApiModel {
    
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

extension ScanResultApiModel {
    
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

extension ScanResultApiModel.Ticket {
    
    struct Buyer : Codable {
        
        let name: String
        let phone: String
        let email: String
    }
}
