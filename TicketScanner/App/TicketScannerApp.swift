//
//  TicketScannerApp.swift
//  Shared
//
//  Created by Dmytro Pogrebniak on 17.05.2021.
//

import SwiftUI

@main
struct TicketScannerApp: App {
    
    let loginStore = LoginStore(state: LoginCredentials(email: "", password: ""))
    let alertObject = AlertObject()
    
    var body: some Scene {
        WindowGroup {
//            RegistrationView()
//                .environmentObject(loginStore)
            EventsListView()
                .environmentObject(alertObject)
        }
    }
}
