//
//  AppRootView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 15.06.2021.
//

import SwiftUI

struct AppRootView: View {
    
    private let loginStore = LoginStore(state: LoginCredentials(email: "", password: ""))

    @EnvironmentObject var appDataStore: AppDataStore
    
    var body: some View {
        Group {
            if !appDataStore.state.isUserAuthorized {
                RegistrationView()
                    .environmentObject(loginStore)
            } else {
                EventsListView()
            }
        }
    }
}
