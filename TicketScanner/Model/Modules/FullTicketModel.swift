//
//  FullTicketModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 11.06.2021.
//

import Foundation

struct FullTicketModel : Identifiable, Equatable {
    
    let id = UUID()
    
    let ticketId : Int
    let main : TicketMainInfoModel
    let status : TicketStatus
    let secondary : TicketSecondaryInfoModel
    
    let timeDouble : Double
    
    init(main: TicketMainInfoModel, status: TicketStatus, secondary: TicketSecondaryInfoModel, timeDouble: Double) {
        self.ticketId = {
            var hasher = Hasher()
            hasher.combine(timeDouble)
            hasher.combine(main.ticketNumber)
            return hasher.finalize()
        }()
        self.main = main
        self.status = status
        self.secondary = secondary
        self.timeDouble = timeDouble
    }
}

struct TicketMainInfoModel : Equatable {
    
    let name : String
    let time : String
    let ticketNumber : String
}

enum TicketStatus : Equatable {
    
    case success
    case invalidQR
    case refunded(time: String?)
    case checkedIn(time: String?, date: String?)
    case wrongEvent(name: String, time: String?)
}

struct TicketSecondaryInfoModel : Equatable {
    
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
            status: .random,
            secondary: secondary,
            timeDouble: Double.random(in: 0...500)
        )
    }
}
