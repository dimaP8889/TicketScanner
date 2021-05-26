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
    
    private let preferences = UserDefaults(suiteName: "DIM defaults")!

    private func apply() {
        preferences.synchronize()
    }
}

// MARK: - Lang
extension Defaults {
    
    var defaultLangKey: String {
        return "ua"
    }
    
    private var currentLangKey: String {
        return "current_lang"
    }
    
    func getCurrentLang() -> String {
        return preferences.string(forKey: currentLangKey) ?? defaultLangKey
    }

    func setCurrentLang(_ code: String) {
        preferences.set(code, forKey: currentLangKey)
        apply()
    }

}
