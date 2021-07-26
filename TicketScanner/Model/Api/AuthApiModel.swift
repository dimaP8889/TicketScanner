//
//  AuthApiModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.06.2021.
//

import Foundation

struct AuthModel: Codable {
    
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
}
