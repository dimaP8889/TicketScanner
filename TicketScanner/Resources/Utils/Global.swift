//
//  Global.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 27.05.2021.
//

import Foundation

// MARK: - Localization
func localStr(_ key: String) -> String {
    let tableName = Defaults.shared.getCurrentLang()
    return NSLocalizedString(key, tableName: tableName, bundle: .main, value: "", comment: "")
}
