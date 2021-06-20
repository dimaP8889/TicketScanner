//
//  LoginCredentialsModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 31.05.2021.
//

import Foundation
import Combine

struct LoginCredentials {
    
    var email : String {
        didSet { setValid() }
    }
    var password : String {
        didSet { setValid() }
    }
    
    var isValid : Bool
    
    var isError : Bool = false
    
    init(email: String, password: String) {
        
        self.email = email
        self.password = password
        
        isValid = true//email.isEmail()
            //&& password.isCorrectPassword()
    }
    
    private mutating func setValid() {
        isValid = email.isEmail()
            && password.isCorrectPassword()
    }
}

enum LoginAction {
    
    case changeEmail(String)
    case changePassword(String)
    case setError(Bool)
}

struct LoginReducer {
    
    func reduce(state: inout LoginCredentials, action: LoginAction) {
        
        switch action {
        case let .changeEmail(email):
            guard !email.isEmpty else { return }
            state.email = email
        case let .changePassword(password):
            guard !password.isEmpty else { return }
            state.password = password
        case let .setError(isError):
            state.isError = isError
        }
    }
}
