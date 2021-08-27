//
//  UnauthorizedApiModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 28.08.2021.
//

import Foundation

struct UnauthorizedApiModel: Codable {
    
    let statusCode: Int
    let error: String
    let message: String
}
