//
//  ParticipantsModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import Foundation

struct ParticipantsInfoModel : Identifiable {
    
    let id = UUID()
    
    let timeNum : Double
    let tickets : [FullTicketModel]
    
    var time : String {
        let time = Date(timeIntervalSince1970: timeNum)
        return time.stringShortTime
    }
}

extension ParticipantsInfoModel {
    
    static var random : ParticipantsInfoModel {
        
        let numberOfTickets = (10...100).randomElement()!
        
        let tickets = (0...numberOfTickets).map { _ in
            FullTicketModel.random
        }
        return ParticipantsInfoModel(timeNum: 2838439893, tickets: tickets)
    }
}
