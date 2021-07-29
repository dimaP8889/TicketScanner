//
//  Date.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.06.2021.
//

import Foundation

extension Date {
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    static var currentTime : String {
        Date().stringShortTime
    }
    
    var stringShortTime : String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = locale
        
        return formatter.string(from: self)
    }
    
    var stringFullTime : String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.locale = locale
        
        return formatter.string(from: self)
    }
    
    var stringDate : String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY"
        formatter.locale = locale
        
        return formatter.string(from: self)
    }
    
    func isSameDay(with date: Date) -> Bool {
        
        let c1 = NSCalendar.current.dateComponents([.year, .month, .day], from: self)
        let c2 = NSCalendar.current.dateComponents([.year, .month, .day], from: date)
        
        if c1.day == c2.day,
           c1.month == c2.month,
           c1.year == c2.year {
            return true
        }
        return false
    }
    
    func time(to date: Date) -> String {
        
        let calendar = NSCalendar.current
        
        let yearsDiff = calendar.dateComponents([.year], from: self, to: date).year ?? 0
        let monthsDiff = (calendar.dateComponents([.month], from: self, to: date).month ?? 0) % 12
        let daysDiff = (calendar.dateComponents([.day], from: self, to: date).day ?? 0) % 30
        let hoursDiff = (calendar.dateComponents([.hour], from: self, to: date).hour ?? 0) % 24
        let minutesDiff = (calendar.dateComponents([.minute], from: self, to: date).minute ?? 0) % 60
        
        if date - self <= 0 {
            return localStr("events.future.started")
        }
        
        if monthsDiff > 0 || yearsDiff > 0 {
            let amount = yearsDiff * 12 + monthsDiff
            return "\(localStr("events.future.2")) \(amount) \(declension(value: amount, key: "months"))"
        }
        
        if daysDiff > 0 {
            return "\(localStr("events.future.1")) \(daysDiff) \(declension(value: daysDiff, key: "days"))"
        }
        
        return "\(localStr("events.future.2")) \(hoursDiff) \(localStr("hours")) \(minutesDiff) \(localStr("min"))"
    }
}

// MARK: - Private
private extension Date {
    
    func declension(value: Int, key: String) -> String {
        
        var number = 2
        
        if (value % 10 == 1 && value % 100 != 11) {
            number = 0
        } else if ((value % 10 >= 2 && value % 10 <= 4) &&
                !(value % 100 >= 12 && value % 100 <= 14))
        {
            number = 1
        }
        
        return localStr(key + ".\(number)")
    }
    
    var locale : Locale {
        
        switch Defaults.shared.getCurrentLang() {
        case "ua":
            return Locale(identifier: "uk_UA")
        default:
            return Locale(identifier: "uk_UA")
        }
    }
}
