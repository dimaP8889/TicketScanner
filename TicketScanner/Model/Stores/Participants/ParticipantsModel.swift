//
//  ParticipantsModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.07.2021.
//

import Foundation
import Combine

struct ParticipantsModel {
    
    var filter : FilterType
    var participantsInfo : [ParticipantsInfoModel]
}

// MARK: - Model
extension ParticipantsModel {
    
    enum FilterType {
        
        case all
        case success
        case failure
    }
}

enum ParticipantsAction {
    
    case changeType(to: ParticipantsModel.FilterType)
    case loadParticipants(name : String)
    case setParticipants(data : [ParticipantsInfoModel])
}

struct ParticipantsReducer {
    
    func reduce(state: inout ParticipantsModel, action: ParticipantsAction) -> AnyPublisher<ParticipantsAction, Never>? {
        
        switch action {
        case let .changeType(to: type):
            state.filter = type
            return nil
        case let .loadParticipants(name):
            return Networking.main?.loadParticipants(with: name)
                .map { ParticipantsAction.setParticipants(data: $0) }
                .eraseToAnyPublisher()
        case let .setParticipants(data):
            state.participantsInfo = data
            return nil
        }
    }
}
