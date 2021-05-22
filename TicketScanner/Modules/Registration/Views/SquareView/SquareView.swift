//
//  SquareView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 17.05.2021.
//

import SwiftUI

struct SquareView: View {
    
    var buttonAlpha : CGFloat
    @Binding var isAccountButtonPressed : Bool
    
    var body: some View {
        
        content
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .foregroundColor(.black)
            )
            .background(Color.clear)
    }
    
    var content: some View {
        
        if isAccountButtonPressed {
            return AnyView(CredentialsView())
        } else {
            return AnyView(CheckInView(buttonAlpha: buttonAlpha) {
                withAnimation(.spring()) {
                    isAccountButtonPressed = true
                }
            })
        }
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(buttonAlpha: 1, isAccountButtonPressed: .constant(true))
    }
}
