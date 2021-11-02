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
    private let appDataStoreCopy = AppStore(initialState: .init(), reducer: mainReducer)
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(appDataStore)
                .environmentObject(appDataStoreCopy)
        }
    }
}
