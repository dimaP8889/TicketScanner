//
//  TicketScannerApp.swift
//  Shared
//
//  Created by Dmytro Pogrebniak on 17.05.2021.
//

import SwiftUI

@main
struct TicketScannerApp: App {
    
    private let appDataStore = AppDataStore(state: AppData())
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(appDataStore)
        }
    }
}
