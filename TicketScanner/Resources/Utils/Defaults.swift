//
//  Defaults.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 27.05.2021.
//

import Foundation

final class Defaults {
    
    static let shared = Defaults()
    private init() {}
    
    private let preferences = UserDefaults(suiteName: "TS defaults")!

    private func apply() {
        preferences.synchronize()
    }
}

// MARK: - Lang
extension Defaults {
    
    var defaultLang: String {
        
        let preferredLanguage = Locale.preferredLanguages[0] as String
        let arr = preferredLanguage.components(separatedBy: "-")
        guard let deviceLanguage = arr.first else {
            return "en"
        }
        
        switch deviceLanguage {
        case "uk":
            return "ua"
        default:
            return "en"
        }
    }
    
    private var currentLangKey: String {
        return "current_lang"
    }
    
    func getCurrentLang() -> String {
        return preferences.string(forKey: currentLangKey) ?? defaultLang
    }

    func setCurrentLang(_ code: String) {
        preferences.set(code, forKey: currentLangKey)
        apply()
    }
}

// MARK: - User
extension Defaults {
    
    var defaultUser: String? {
        return nil
    }
    
    private var currentUserKey: String {
        return "current_user"
    }
    
    func getCurrentUser() -> String? {
        return preferences.string(forKey: currentUserKey) ?? defaultUser
    }

    func setCurrentUser(_ name: String) {
        preferences.set(name, forKey: currentUserKey)
        apply()
    }
}

