//
//  FullTicketModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 11.06.2021.
//

import Foundation

struct FullTicketModel {
    
    let main : TicketMainInfoModel
    let status : TicketStatus
    let secondary : TicketSecondaryInfoModel
}

struct TicketMainInfoModel {
    
    let name : String
    let time : String
    let ticketNumber : String
}

enum TicketStatus {
    
    case refunded(time: String)
    case checkedIn(time: String, date: String)
    case wrongEvent(name: String, time: String)
}

struct TicketSecondaryInfoModel {
    
    let type : String
    let number : String
    let email : String
}

extension TicketStatus {
    
    static var random : TicketStatus {
        
        let events = ["Uncertain Festival Official Afterparty @ K41"]
        let mainTimes = ["18:54:13", "21:33:27", "05:19:45"]
        let dates = ["21 серпня 2021", "1 червня 2021", "14 квітня 2021"]
        
        let statuses : [TicketStatus] = [
            .checkedIn(time: mainTimes.randomElement()!, date: dates.randomElement()!),
            .refunded(time: dates.randomElement()!),
            .wrongEvent(name: events.randomElement()!, time: dates.randomElement()!)
        ]
        return statuses.randomElement()!
    }
}

extension FullTicketModel {
    
    static var random : FullTicketModel {
        
        let names = ["Vetralan Hampston", "Talan Vetrovs", "Jaydon Baptista", "Gretchen Siphron"]
        let mainTimes = ["18:54:13", "21:33:27", "05:19:45"]
        let ticketNumbers = ["1214Q67839ZX"]
        
        
        let main = TicketMainInfoModel(
            name: names.randomElement()!,
            time: mainTimes.randomElement()!,
            ticketNumber: ticketNumbers.randomElement()!
        )
        
        let secondary = TicketSecondaryInfoModel(
            type: "UNCERTAIN FESTIVAL AFTERPARTY PASS",
            number: "+38 067 3****11",
            email: "jax**********76@yahoo.com"
        )
        
        return FullTicketModel(
            main: main,
            status: TicketStatus.random,
            secondary: secondary
        )
    }
}
