//
//  Requestable.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.06.2021.
//

import Foundation
import Combine

protocol Requestable {
    
    func parameters() -> [String:String]
    func formData() -> [String:Any]
    func headers() -> [String:String]
    func endPointRoute() -> String
    func authorizationRequired() -> Bool
    func httpMethod() -> String
}

extension Requestable {
    
    func parameters() -> [String : String] {
        return [:]
    }
    
    func formData() -> [String : Any] {
        return [:]
    }
    
    func headers() -> [String : String] {
        let lang = Defaults.shared.getCurrentLang()
        return [
            "Content-Type" : "application/json",
            "Accept-Language" : "\(lang)"
        ]
    }
    
    func authorizationRequired() -> Bool {
        return false
    }
    
    func httpMethod() -> String {
        return "GET"
    }
}
