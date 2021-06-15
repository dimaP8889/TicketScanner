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
    
    func reduce(oldState: AppData, action: AppDataAction) -> AppData {
        
        switch action {
        case .setToken(_):
            let newState = AppData(isUserAuthorized: true)
            return newState
        case .removeToken:
            let newState = AppData()
            return newState
        }
    }
}
