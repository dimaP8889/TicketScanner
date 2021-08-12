//
//  ParticipantsModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.07.2021.
//

import Foundation
import Combine

struct ParticipantsModel {
    
    var eventId : String
    var filter : FilterType
    var participantsInfo : VisitiorsApiModel
    
    init(eventId : String) {
        
        self.eventId = eventId
        filter = .all
        participantsInfo = .init(checkins: [])
    }
}

// MARK: - Model
extension ParticipantsModel {
    
    enum FilterType : String {
        
        case all = "all"
        case success = "ok"
        case failure = "not_ok"
    }
}

enum ParticipantsAction {
    
    case changeType(to: ParticipantsModel.FilterType)
    case loadParticipants(name : String, filter: String, eventId: String)
    case setParticipants(response : Response<VisitiorsApiModel, ErrorResponse>)
}

struct ParticipantsReducer {
    
    func reduce(state: inout ParticipantsModel, action: ParticipantsAction) -> AnyPublisher<ParticipantsAction, Never>? {
        
        switch action {
        case let .changeType(to: type):
            state.filter = type
            return nil
        case let .loadParticipants(name, filter, eventId):
            return Networking.main?.loadParticipants(with: name, filter: filter, eventId: eventId)
                .map { data in ParticipantsAction.setParticipants(response: data) }
                .eraseToAnyPublisher()
        case let .setParticipants(response):
            switch response {
            case let .success(data):
                state.participantsInfo = data
                return nil
            case let .backend(error):
                print(error)
                return nil
            case let .system(error):
                print(error)
                return nil
            }
        }
    }
}
