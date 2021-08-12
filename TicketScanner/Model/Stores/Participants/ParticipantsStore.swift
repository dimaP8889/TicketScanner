//
//  ParticipantsStore.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.07.2021.
//

import Foundation
import Combine

final class ParticipantsStore : ObservableObject {
    
    @Published private(set) var state : ParticipantsModel
    private var cancellables: Set<AnyCancellable> = []
    
    private var reducer: ParticipantsReducer
    
    init(eventId : String) {
        state = ParticipantsModel(eventId: eventId)
        reducer = ParticipantsReducer()
    }
    
    func dispatch(action: ParticipantsAction) {
        
        guard let effect = reducer.reduce(state: &state, action: action) else {
            return
        }
        
        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dispatch(action:))
            .store(in: &cancellables)
    }
}

// MARK: - Public Variables
extension ParticipantsStore {
    
    var filter : String {
        state.filter.rawValue
    }
    
    #warning("Set time")
    var participants : [ParticipantsInfoModel] {
        let tickets = state.participantsInfo.adaptToFullTicketModel()
        return [ParticipantsInfoModel(time: "00:00", tickets: tickets)]
    }
    
    var eventId : String {
        state.eventId
    }
}
