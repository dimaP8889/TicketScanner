//
//  ParticipantsModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.07.2021.
//

import Foundation
import Combine

struct ParticipantsModel : Equatable {
    
    var eventId : String
    var filter : FilterType
    var participantsInfo : VisitiorsApiModel
    var searchText : String
    
    var openedTicked : Int?
    
    var participants : [ParticipantsInfoModel] {
        let sorted = participantsInfo.sortByTime()
        return sorted.map { (hour, model) in
            return ParticipantsInfoModel(
                timeNum: Double((hour + 1) * 3600),
                tickets: model.adaptToFullTicketModel()
            )
        }
        .sorted { $0.timeNum > $1.timeNum }
    }
    
    init(eventId : String) {
        
        self.eventId = eventId
        filter = .all
        searchText = ""
        participantsInfo = .init(checkins: [])
        openedTicked = nil
    }
}

// MARK: - Model
extension ParticipantsModel {
    
    enum FilterType : String, Equatable {
        
        case all = "all"
        case success = "ok"
        case failure = "not_ok"
    }
}

enum ParticipantsAction {
    
    case setEvent(id : String)
    case openTicket(hash: Int)
    case closeTicket
    case changeType(to: ParticipantsModel.FilterType)
    case loadParticipants
    case changeSearch(text: String)
    case setParticipants(response : Response<VisitiorsApiModel, ErrorResponse>)
}
