//
//  AppData.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 15.06.2021.
//

import Foundation

struct AppData {
    
    var isUserAuthorized : Bool = false
}

enum AppDataAction {
    
    case setToken(String)
    case removeToken
}

struct AppDataReducer {
    
    func reduce(state: inout AppData, action: AppDataAction) {
        
        switch action {
        case .setToken(_):
            state.isUserAuthorized = true
        case .removeToken:
            state.isUserAuthorized = false
        }
    }
}
