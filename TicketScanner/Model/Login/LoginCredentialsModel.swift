//
//  LoginCredentialsModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 31.05.2021.
//

import Foundation
import Combine

struct LoginCredentials {
    
    var email : String
    var password : String
    
    var isValid : Bool
    
    init(email: String, password: String) {
        
        self.email = email
        self.password = password
        
        isValid = email.isEmail()
            && password.isCorrectPassword()
    }
}

enum LoginAction {
    
    case changeEmail(String)
    case changePassword(String)
}

struct LoginReducer {
    
    func reduce(oldState: LoginCredentials, action: LoginAction) -> LoginCredentials {
        
        switch action {
        case let .changeEmail(email):
            guard !email.isEmpty else { return oldState }
            let newState = LoginCredentials(email: email, password: oldState.password)
            return newState
        case let .changePassword(password):
            guard !password.isEmpty else { return oldState }
            let newState = LoginCredentials(email: oldState.email, password: password)
            return newState
        }
    }
}
