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
    
    case loadParticipants(name: String)
}

extension API where RQ == MainApi {
    
    func signin(username: String, password: String) -> AnyPublisher<Response<AuthModel>, Never> {
        sync(.authorize(user: username, password: password))
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
}

extension MainApi : Requestable {
    
    func endPointRoute() -> String {
        return "/signin"
    }
    
    func formData() -> [String : Any] {
        switch self {
        case let .authorize(user, password):
            return [
                "username" : user,
                "password" : password
            ]
        case  .loadParticipants:
            return [:]
        }
    }
    
    func httpMethod() -> String {
        return "POST"
    }
}
