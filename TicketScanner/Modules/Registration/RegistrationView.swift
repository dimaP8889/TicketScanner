//
//  ContentView.swift
//  Shared
//
//  Created by Dmytro Pogrebniak on 17.05.2021.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var topInset : CGFloat = UIScreen.main.bounds.height
    @State private var squareButtonAlpha : CGFloat = 0
    @State private var isAccountButtonPressed : Bool = false
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                    .frame(width: 0, height: topInset)
                SquareView(
                    buttonAlpha: squareButtonAlpha,
                    isAccountButtonPressed: $isAccountButtonPressed.animation(.easeOut(duration: 1))
                )
                .frame(
                    width: isAccountButtonPressed ? UIScreen.main.bounds.width - 24 : 243,
                    height: 262
                )
                Spacer()
            }
            Spacer()
        }
        .padding([.leading], 12)
        .onAppear {
            let baseAnimation = Animation.spring(
                response: 1,
                dampingFraction: 0.7,
                blendDuration: 1
            )
            withAnimation(baseAnimation) {
                squareButtonAlpha = 1
                topInset = 18
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .previewDevice("iPod touch (7th generation)")
    }
}
