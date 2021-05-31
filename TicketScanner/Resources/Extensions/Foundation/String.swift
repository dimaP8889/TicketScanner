//
//  String.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 31.05.2021.
//

import Foundation

extension String {
    
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: [])
        return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func isCorrectPassword() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[?=.*\\W+A-Za-z0-9_]{6,}$", options: [])
        return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, utf16.count)) != nil
    }
}
