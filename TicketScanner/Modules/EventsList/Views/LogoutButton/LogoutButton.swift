//
//  LogoutButton.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.06.2021.
//

import SwiftUI

struct LogoutButton: View {
    
    var logoutAction : Action
    
    var body: some View {
        Button(action: {
            logoutAction()
        }, label: {
            Text(localStr("events.logout.title"))
                .font(.main(size: 17))
                .foregroundColor(.radicalRed)
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 10)
                .padding(.top, 6)
        })
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.radicalRedTransparent)
        )
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButton(logoutAction: {})
    }
}
