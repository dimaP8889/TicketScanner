//
//  App.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 25.10.2021.
//

import Foundation
import Combine

typealias AppStore = Store<AppState, AppAction>

enum AppAction {
    case app(action : AppDataAction)
    case events(action : EventListAction)
    case login(action : LoginAction)
    case scan(action : ScanAction)
    case participants(action : ParticipantsAction)
}

struct AppState {
    var app : AppData = .init()
    var event : EventListModel = .init()
    var login : LoginCredentials = .init(email: "", password: "")
    var scan : ScanModel = .init()
    var participants : ParticipantsModel = .init(eventId: "")
}


// MARK: - Reducers

// Main
func mainReducer(state: inout AppState, action: AppAction) -> AnyPublisher<AppAction, Never>? {
    
    switch action {
    case let .app(action):
        return appReducer(state: &state.app, action: action)?
            .map(AppAction.app)
            .eraseToAnyPublisher()
    case let .events(action):
        return eventsListReducer(state: &state.event, action: action)?
            .map(AppAction.events)
            .eraseToAnyPublisher()
    case let .login(action):
        return loginReducer(state: &state.login, action: action)?
            .map(AppAction.login)
            .eraseToAnyPublisher()
    case let .scan(action):
        return scanReducer(state: &state.scan, action: action)?
            .map(AppAction.scan)
            .eraseToAnyPublisher()
    case let .participants(action):
        return participantsReducer(state: &state.participants, action: action)?
            .map(AppAction.participants)
            .eraseToAnyPublisher()
    }
}

// App Data
private func appReducer(state: inout AppData, action: AppDataAction) -> AnyPublisher<AppDataAction, Never>? {
    switch action {
    case let .setToken(token):
        if Keychain.shared.setAccess(token) == nil {
            state.isUserAuthorized = true
        }
    case .removeToken:
        Keychain.shared.removeAccess()
        state.isUserAuthorized = false
    }
    return nil
}


// Event List
private func eventsListReducer(state: inout EventListModel, action: EventListAction) -> AnyPublisher<EventListAction, Never>? {
    
    switch action {
    case .load:
        return Networking.main?.loadEvents()
            .map { EventListAction.set($0) }
            .eraseToAnyPublisher()
    case let .set(response):
        switch response {
        case let .success(model):
            var events = model.adaptToEventModelList
            events.sort { $0.startDate > $1.startDate }
            state.eventList = events
        case .expiredToken:
            break//expiredTokenAction?()
        default:
            break
        }
        return nil
    }
}

// Login
private func loginReducer(state: inout LoginCredentials, action: LoginAction) -> AnyPublisher<LoginAction, Never>? {
    
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
            break//expiredTokenAction?()
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

// Scan
private func scanReducer(state: inout ScanModel, action: ScanAction) -> AnyPublisher<ScanAction, Never>? {
    
    switch action {
    case .hideAlert:
        state.alertModel = nil
    case let .showAlert(model):
        state.alertModel = model
    case .showManual:
        state.isManual = true
        state.alertModel = nil
    case .hideManual:
        state.isManual = false
        state.alertModel = nil
    case .showTicket:
        let hasTicket = state.alertModel?.alertType.ticket != nil
        state.isTicketPresented = hasTicket
    case let .scan(validation):
        return Networking.main?.scan(validation: validation, eventId: state.eventId)
            .map { ScanAction.setScanResult($0, validation) }
            .eraseToAnyPublisher()
    case let .setScanResult(response, validation):
        return parseScanResult(response: response, validation: validation, state: &state)
    }
    return nil
}

private func parseScanResult(
    response: Response<ScanSuccessResultApiModel, ScanFailResultApiModel>,
    validation: String,
    state: inout ScanModel
) -> AnyPublisher<ScanAction, Never>? {
    
    switch response {
    case .success:
        let alert = AlertModel(time: Date.currentTime, alertType: .success)
        state.ticketModel = nil
        return scanReducer(state: &state, action: .showAlert(alert))
    case let .backend(errorObject):
        let alert = errorObject.adaptToAlert(number: validation)
        state.ticketModel = alert.alertType.ticket
        return scanReducer(state: &state, action: .showAlert(alert))
    case let .system(error):
        print(error)
        return nil
    case .expiredToken:
        //expiredTokenAction?()
        return nil
    }
}

// Participants
private func participantsReducer(state: inout ParticipantsModel, action: ParticipantsAction) -> AnyPublisher<ParticipantsAction, Never>? {
    
    switch action {
    case let .changeType(type):
        state.filter = type
        state.openedTicked = nil
        return participantsReducer(state: &state, action: .loadParticipants)
    case let .changeSearch(text):
        state.searchText = text
        return participantsReducer(state: &state, action: .loadParticipants)
    case .loadParticipants:
        return Networking.main?.loadParticipants(with: state.searchText, filter: state.filter.rawValue, eventId: state.eventId)
            .map { data in ParticipantsAction.setParticipants(response: data) }
            .eraseToAnyPublisher()
    case let .setParticipants(response):
        switch response {
        case let .success(data):
            state.participantsInfo = data
            return nil
        case let .backend(error):
            print(error)
            return nil
        case let .system(error):
            print(error)
            return nil
        case .expiredToken:
            //expiredTokenAction?()
            return nil
        }
    case let .openTicket(hash):
        if state.openedTicked == hash {
            return participantsReducer(state: &state, action: .closeTicket)
        } else {
            state.openedTicked = hash
        }
        return nil
    case .closeTicket:
        state.openedTicked = nil
        return nil
    }
}
