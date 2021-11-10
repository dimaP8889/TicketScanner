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
