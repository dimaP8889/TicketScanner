//
//  LoginCredentialsStore.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 31.05.2021.
//

import Combine
import SwiftUI

final class LoginStore : ObservableObject {
    
    @Published private(set) var state : LoginCredentials
    private var cancellables: Set<AnyCancellable> = []
    
    private var reducer: LoginReducer
    
    init(state : LoginCredentials) {
        self.state = state
        reducer = LoginReducer()
    }
    
    func setExpiredAction(expiredTokenAction : Action?) {
        reducer.expiredTokenAction = expiredTokenAction
    }
    
    func dispatch(action: LoginAction) {
        
        guard let effect = reducer.reduce(state: &state, action: action) else {
            return
        }
        
        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dispatch(action:))
            .store(in: &cancellables)
    }
}
