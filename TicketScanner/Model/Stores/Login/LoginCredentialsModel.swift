//
//  LoginCredentialsModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 31.05.2021.
//

import Foundation
import Combine

struct LoginCredentials : Equatable {
    
    var email : String {
        didSet { setValid() }
    }
    var password : String {
        didSet { setValid() }
    }
    
    var isValid : Bool = false
    var isError : Bool = false
    
    init(email: String, password: String) {
        
        self.email = email
        self.password = password
        setValid()
    }
    
    mutating func clear() {
        email = ""
        password = ""
        isValid = false
        isError = false
    }
    
    private mutating func setValid() {
        
        isValid = email.isEmail()
            && password.isCorrectPassword()
    }
}

enum LoginAction {
    
    case changeEmail(String)
    case changePassword(String)
    case setLoginState(Response<AuthModel, ErrorResponse>, String, TypeAction<String>)
    case logIn(TypeAction<String>)
}

struct LoginReducer {
    
    var expiredTokenAction : Action?
    
    func reduce(state: inout LoginCredentials, action: LoginAction) -> AnyPublisher<LoginAction, Never>? {
        
        switch action {
        case let .changeEmail(email):
            guard !email.isEmpty else { return nil }
            state.email = email
        case let .changePassword(password):
            guard !password.isEmpty else { return nil }
            state.password = password
        case let .setLoginState(response, user, successAction):
            switch response {
            case let .success(model):
                state.clear()
                Defaults.shared.setCurrentUser(user)
                successAction((model.accessToken))
            case .expiredToken:
                expiredTokenAction?()
            default:
                state.isError = true
            }
        case let .logIn(successAction):
            let user = state.email
            return Networking.main?.signin(username: user, password: state.password)
                .map { LoginAction.setLoginState($0, user, successAction) }
                .eraseToAnyPublisher()
        }
        return nil
    }
}
