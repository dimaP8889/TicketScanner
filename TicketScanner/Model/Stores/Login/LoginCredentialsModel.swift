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
        
        #warning("Remove later")
            if email == "test_me_public" && password == "privetKakDela?" {
            isValid = true
        }
    }
}

enum LoginAction {
    
    case changeEmail(String)
    case changePassword(String)
    case setLoginState(Response<AuthModel>, TypeAction<String>)
    case logIn(TypeAction<String>)
}

struct LoginReducer {
    
    func reduce(state: inout LoginCredentials, action: LoginAction) -> AnyPublisher<LoginAction, Never>? {
        
        switch action {
        case let .changeEmail(email):
            guard !email.isEmpty else { return nil }
            state.email = email
        case let .changePassword(password):
            guard !password.isEmpty else { return nil }
            state.password = password
        case let .setLoginState(response, successAction):
            switch response {
            case let .success(model):
                state.clear()
                successAction(model.accessToken)
            case .failure:
                state.isError = true
            }
        case let .logIn(successAction):
            return Networking.main?.signin(username: state.email, password: state.password)
                .map { LoginAction.setLoginState($0,successAction) }
                .eraseToAnyPublisher()
        }
        return nil
    }
}
