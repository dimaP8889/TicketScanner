//
//  AppRootView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 15.06.2021.
//

import SwiftUI

struct AppRootView: View {

    @EnvironmentObject var appDataStore: AppStore
    
    var body: some View {
        Group {
            if !appDataStore.state.app.isUserAuthorized {
                RegistrationView()
            } else {
                EventsListView()
            }
        }
    }
}
