//
//  ParticipantsModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import Foundation

struct ParticipantsInfoModel : Identifiable {
    
    let id = UUID()
    
    let time : String
    let tickets : [FullTicketModel]
}

extension ParticipantsInfoModel {
    
    static var random : ParticipantsInfoModel {
        
        let times = ["19:00", "13:27", "10:12", "17:45", "21:00", "04:09", "01:17", "12:50", "23:45", "20:11"]
        
        let numberOfTickets = (10...100).randomElement()!
        
        let tickets = (0...numberOfTickets).map { _ in
            FullTicketModel.random
        }
        let time = times.randomElement()!
        return ParticipantsInfoModel(time: time, tickets: tickets)
    }
}
