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
    
    init() {
        state = ParticipantsModel(filter: .all)
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
