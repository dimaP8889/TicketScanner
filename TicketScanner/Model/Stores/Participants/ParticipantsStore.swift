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
    
    var participants : [ParticipantsInfoModel] {
        let sorted = state.participantsInfo.sortByTime()
        return sorted.map { (hour, model) in
            return ParticipantsInfoModel(
                timeNum: Double((hour + 1) * 3600),
                tickets: model.adaptToFullTicketModel()
            )
        }
        .sorted { $0.timeNum > $1.timeNum }
    }
    
    var eventId : String {
        state.eventId
    }
    
    var openedTicket : Int? {
        state.openedTicked
    }
}
