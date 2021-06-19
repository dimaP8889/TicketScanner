//
//  AccessToken.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.06.2021.
//

import Foundation

extension Keychain {
    
    private var access: String {
        "access"
    }
    
    var accessToken: String? {
        return get(access)
    }
    
    func setAccess(_ token: String) -> String? {
        guard let error = set(token, forKey: access) else {
            return nil
        }
        return "\(error)"
    }
    
    func removeAccess() {
        delete(by: access)
    }
}
