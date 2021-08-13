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
    var searchText : String
    
    init(eventId : String) {
        
        self.eventId = eventId
        filter = .all
        searchText = ""
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
    case loadParticipants
    case changeSearch(text: String)
    case setParticipants(response : Response<VisitiorsApiModel, ErrorResponse>)
}

struct ParticipantsReducer {
    
    func reduce(state: inout ParticipantsModel, action: ParticipantsAction) -> AnyPublisher<ParticipantsAction, Never>? {
        
        switch action {
        case let .changeType(type):
            state.filter = type
            return reduce(state: &state, action: .loadParticipants)
        case let .changeSearch(text):
            state.searchText = text
            return reduce(state: &state, action: .loadParticipants)
        case .loadParticipants:
            return Networking.main?.loadParticipants(with: state.searchText, filter: state.filter.rawValue, eventId: state.eventId)
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
