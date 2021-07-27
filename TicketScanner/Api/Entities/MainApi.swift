//
//  MainApi.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.06.2021.
//

import Foundation
import Combine

enum MainApi {
    
    case authorize(user: String, password: String)
    case loadEvents
    case loadParticipants(name: String)
    case scan(validation: String, eventId : String)
}

extension API where RQ == MainApi {
    
    func signin(username: String, password: String) -> AnyPublisher<Response<AuthModel, ErrorResponse>, Never> {
        sync(.authorize(user: username, password: password))
    }
    
    func loadEvents() -> AnyPublisher<Response<EventListApiModel, ErrorResponse>, Never> {
        sync(.loadEvents)
    }
    
    func loadParticipants(with name : String) -> AnyPublisher<[ParticipantsInfoModel], Never> {
        let numberOfTickets = (3...10).randomElement()!
        let part = (0...numberOfTickets).map { _ in
            ParticipantsInfoModel.random
        }
        let publisher = part.publisher
        return publisher
            .collect()
            .eraseToAnyPublisher()
    }
    
    func scan(validation: String, eventId: String) -> AnyPublisher<Response<ScanSuccessResultApiModel, ScanFailResultApiModel>, Never> {
        sync(.scan(validation: validation, eventId: eventId))
    }
}

extension MainApi : Requestable {
    
    func endPointRoute() -> String {
        switch self {
        case .authorize:
            return "/signin"
        case .loadEvents:
            return "/events"
        case .loadParticipants:
            return ""
        case .scan:
            return "/scan"
        }
    }
    
    func formData() -> [String : Any] {
        switch self {
        case let .authorize(user, password):
            return [
                "username" : user,
                "password" : password
            ]
        case .loadEvents:
            return [:]
        case  .loadParticipants:
            return [:]
        case let .scan(validation, eventId):
            return [
                "ticketValidationString": validation,
                "eventId": eventId,
                "entryMode": "qr"
            ]
        }
    }
    
    func headers() -> [String : String] {
        return ["Content-Type": "application/json"]
    }
    
    func httpMethod() -> String {
        switch self {
        case .loadEvents, .loadParticipants:
            return "GET"
        case .authorize, .scan:
            return "POST"
        }
    }
    
    func authorizationRequired() -> Bool {
        switch self {
        case .loadEvents, .scan:
            return true
        default:
            return false
        }
    }
}
