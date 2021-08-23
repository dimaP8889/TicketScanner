//
//  SquareView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 17.05.2021.
//

import SwiftUI

struct SquareView: View {
    
    var buttonAlpha : CGFloat
    var isAccountButtonPressed : Bool
    
    var body: some View {
        
        ZStack {
            if isAccountButtonPressed {
                CredentialsView()
            } else {
                CheckInView(
                    alpha: buttonAlpha
                )
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(.black)
        )
        .background(Color.clear)
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(buttonAlpha: 1, isAccountButtonPressed: false)
    }
}
