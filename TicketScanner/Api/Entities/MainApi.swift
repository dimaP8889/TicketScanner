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
}

extension API where RQ == MainApi {
    
    func signin(username: String, password: String) -> AnyPublisher<Response<AuthModel>, Never> {
        sync(.authorize(user: username, password: password))
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
        }
    }
    
    func httpMethod() -> String {
        return "POST"
    }
}
