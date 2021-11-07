//
//  MainStore.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 25.10.2021.
//

import Foundation
import Combine
import SwiftUI

final class Store<State, Action>: ObservableObject {
    
    typealias Reducer<State, Action> = (inout State, Action) -> AnyPublisher<Action, Never>?
    
    @Published private(set) var state: State
    
    private let reducer : Reducer<State, Action>
    private var cancellables: [AnyCancellable] = []
    
    init(
        initialState: State,
        reducer: @escaping Reducer<State, Action>
    ) {
        self.state = initialState
        self.reducer = reducer
    }
    
    func derived<DerivedState: Equatable, ExtractedAction>(
        deriveState: @escaping (State) -> DerivedState,
        embedAction: @escaping (ExtractedAction) -> Action
    ) -> Store<DerivedState, ExtractedAction> {
        
        let store = Store<DerivedState, ExtractedAction>(
            initialState: deriveState(state),
            reducer: { _, action in
                self.send(embedAction(action))
                return Empty().eraseToAnyPublisher()
            }
        )
        $state
            .map(deriveState)
            .receive(on: DispatchQueue.main)
            .assign(to: &store.$state)
        
        return store
    }
    
    func send(_ action : Action) {
        
        guard let effect = reducer(&state, action) else {
            return
        }

        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: send)
            .store(in: &cancellables)
    }
}
