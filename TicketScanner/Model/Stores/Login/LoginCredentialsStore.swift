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
    
    private var reducer: LoginReducer
    
    init(state : LoginCredentials) {
        self.state = state
        reducer = LoginReducer()
    }
    
    func dispatch(action: LoginAction) {
        
        let newState = reducer.reduce(oldState: state, action: action)
        state = newState
    }
}
