//
//  ProfileView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 07.06.2021.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var appDataStore: AppDataStore
    
    var body: some View {
        VStack(spacing: 12) {
            ProfileSquareView()
            LogoutBigButton {
                appDataStore.dispatch(action: .removeToken)
            }
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
