//
//  App.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 25.10.2021.
//

import Foundation

enum AppAction {
    case app(action : AppDataAction)
    case events(action : EventListAction)
    case login(action : LoginAction)
    case scan(action : ScanAction)
    case participants(action : ParticipantsAction)
}

struct AppStates {
    var app : AppData
    var event : EventListModel
    var login : LoginCredentials
    var scan : ScanModel
    var participants : ParticipantsModel
}
