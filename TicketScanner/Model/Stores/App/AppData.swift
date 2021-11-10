//
//  AppData.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 15.06.2021.
//

import Foundation

struct AppData : Equatable {
    
    var isUserAuthorized : Bool = (Keychain.shared.accessToken != nil)
}

enum AppDataAction {
    
    case setToken(String)
    case removeToken
}
