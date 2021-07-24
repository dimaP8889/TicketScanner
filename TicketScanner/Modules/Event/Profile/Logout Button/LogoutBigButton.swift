//
//  LogoutBigButton.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import SwiftUI

struct LogoutBigButton: View {
    
    var logoutAction : Action
    
    private var width = UIScreen.main.bounds.width - 24
    
    init(logoutAction: @escaping Action) {
        self.logoutAction = logoutAction
    }
    
    var body: some View {
        Button(action: {
            logoutAction()
        }, label: {
            Text(localStr("events.logout.title"))
                .font(.main(size: 17))
                .foregroundColor(.radicalRed)
                .frame(width: width, height: 62)
        })
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.radicalRedTransparent)
        )
    }
}

struct LogoutBigButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoutBigButton(logoutAction: {})
    }
}
