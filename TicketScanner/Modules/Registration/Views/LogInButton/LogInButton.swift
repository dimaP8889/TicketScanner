//
//  LogInButton.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 22.05.2021.
//

import SwiftUI

struct LogInButton: View {
    
    var isButtonActive : Bool
    var buttonPressAction : Action
    
    var body: some View {
        Button(action: {
            buttonPressAction()
        },
        label: {
            Text(localStr("registration.button.title"))
                .font(.main(size: 20))
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 24, height: 62)
        })
        .disabled(!isButtonActive)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(isButtonActive ? .codGray : .codGrayTransparent)
        )
    }
}

struct LogInButton_Previews: PreviewProvider {
    
    static var previews: some View {
        LogInButton(isButtonActive: true, buttonPressAction: {})
    }
}
