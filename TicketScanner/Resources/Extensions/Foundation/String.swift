//
//  String.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 31.05.2021.
//

import Foundation
import UIKit

extension String {
    
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: [])
        return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func isCorrectPassword() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[?=.*\\W+A-Za-z0-9_]{6,}$", options: [])
        return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func width(constraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    var securedEmail : String {
        
        let components = components(separatedBy: "@")
        
        guard let firstPart = components.first,
              components.count > 1 else {
            return self
        }
        
        var newString : String
        switch firstPart.count {
        case 0...2:
            newString = "**"
        case 3...4:
            newString = firstPart.prefix(2) + "**" + firstPart.dropFirst(4)
        case 5...8:
            newString = firstPart.prefix(1) + "****" + firstPart.dropFirst(5)
        case 9...12:
            newString = firstPart.prefix(3) + "****" + firstPart.dropFirst(7)
        case 13...20:
            newString = firstPart.prefix(6) + "******" + firstPart.dropFirst(12)
        case 21...:
            newString = firstPart.prefix(6) + "********" + firstPart.dropFirst(14)
        default:
            return self
        }
        
        for (index, component) in components.enumerated() {
            if index == 0 { continue }
            newString += "@"
            newString += component
        }
        return newString
    }
    
    var securedNumber : String {
        
        guard count > 6 else {
            return "****"
        }
        
        return prefix(count - 6) + "****" + suffix(2)
    }
}
