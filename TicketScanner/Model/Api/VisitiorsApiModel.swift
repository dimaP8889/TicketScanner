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
    }
}

extension VisitiorsApiModel {
    
    func adaptToFullTicketModel() -> [FullTicketModel] {
        
        return checkins.map { checkin in
            
            #warning("Ticket Number")
            guard let buyer = checkin.buyer else { return nil }
            
            let time = Date(timeIntervalSince1970: TimeInterval(checkin.timestamp / 1000)).stringFullTime
            let main = TicketMainInfoModel(name: buyer.name, time: time, ticketNumber: "Lol")
            
            let status : TicketStatus = {
                
                switch checkin.result {
                case "ok":
                    return .success
                case "not_ok":
                    return .wrongEvent(name: "", time: "")
                default:
                    return .success
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
