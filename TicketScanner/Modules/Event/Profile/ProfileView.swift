//
//  ProfileView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 07.06.2021.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var appDataStore: Store<AppData, AppDataAction>
    
    var body: some View {
        VStack(spacing: 12) {
            ProfileSquareView()
            LogoutBigButton {
                appDataStore.send(.removeToken)
            }
            Spacer()
        }
        .padding(.top, 18)
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
