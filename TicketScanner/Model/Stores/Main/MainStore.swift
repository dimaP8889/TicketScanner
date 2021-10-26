//
//  MainStore.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 25.10.2021.
//

import Foundation
import Combine
import SwiftUI

final class Store<State, Action, Environment>: ObservableObject {
    
    typealias Reducer<State, Action, Environment> = (inout State, Action, Environment) -> AnyPublisher<Action, Never>?
    
    @Published private(set) var state: State
    
    private let environment: Environment
    private let reducer : Reducer<State, Action, Environment>
    private var cancellables: [AnyCancellable] = []
    
    init(
        initialState: State,
        environment: Environment,
        reducer: @escaping Reducer<State, Action, Environment>
    ) {
        self.state = initialState
        self.environment = environment
        self.reducer = reducer
    }
    
    func derived<DerivedState: Equatable, ExtractedAction>(
        deriveState: @escaping (State) -> DerivedState,
        embedAction: @escaping (ExtractedAction) -> Action
    ) -> Store<DerivedState, ExtractedAction, Environment> {
        
        let store = Store<DerivedState, ExtractedAction, Environment>(
            initialState: deriveState(state),
            environment: environment,
            reducer: { _, action, _ in
                self.send(embedAction(action))
                return Empty().eraseToAnyPublisher()
            }
        )
        $state
            .map(deriveState)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: &store.$state)
        return store
    }
    
    func send(_ action : Action) {
        
        guard let effect = reducer(&state, action, environment) else {
            return
        }

        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: send)
            .store(in: &cancellables)
    }
}
