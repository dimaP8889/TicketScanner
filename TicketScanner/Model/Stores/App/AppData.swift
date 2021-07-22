//
//  AppData.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 15.06.2021.
//

import Foundation

struct AppData {
    
    var isUserAuthorized : Bool = (Keychain.shared.accessToken != nil)
}

enum AppDataAction {
    
    case setToken(String)
    case removeToken
}

struct AppDataReducer {
    
    func reduce(state: inout AppData, action: AppDataAction) {
        
        switch action {
        case let .setToken(token):
            if Keychain.shared.setAccess(token) == nil {
                state.isUserAuthorized = true
            }
        case .removeToken:
            Keychain.shared.removeAccess()
            state.isUserAuthorized = false
        }
    }
}
