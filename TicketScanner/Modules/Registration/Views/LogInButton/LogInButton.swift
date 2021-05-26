//
//  LogInButton.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 22.05.2021.
//

import SwiftUI

struct LogInButton: View {
    
    @Binding var isButtonActive : Bool
    var buttonPressAction : Action
    
    var body: some View {
        Button(action: {
            buttonPressAction()
        },
        label: {
            Text(localStr("registration.button.title"))
                .font(.main(size: 20))
                .foregroundColor(.white)
                .padding([.top, .bottom], 20)
        })
        .disabled(!isButtonActive)
        .frame(width: UIScreen.main.bounds.width - 24, height: 62)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(isButtonActive ? .codGray : .codGrayTransparent)
        )
    }
}

struct LogInButton_Previews: PreviewProvider {
    
    static var previews: some View {
        LogInButton(isButtonActive: .constant(true), buttonPressAction: {})
    }
}
