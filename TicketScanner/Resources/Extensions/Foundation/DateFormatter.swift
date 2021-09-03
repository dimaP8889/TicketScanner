//
//  DateFormatter.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.06.2021.
//

import Foundation

extension DateFormatter {
    
    static var eventFormatter : DateFormatter {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd MMMM"
        
        switch Defaults.shared.getCurrentLang() {
        case "ua":
            dateFormatter.locale = Locale(identifier: "uk_UA")
        default:
            dateFormatter.locale = Locale(identifier: "en")
        }
        return dateFormatter
    }
}
