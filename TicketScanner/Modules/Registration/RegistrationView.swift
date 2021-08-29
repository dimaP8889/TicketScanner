//
//  ContentView.swift
//  Shared
//
//  Created by Dmytro Pogrebniak on 17.05.2021.
//

import SwiftUI

// Need Refactor Dimas
struct RegistrationView: View {
    
    @State private var topInset : CGFloat = UIScreen.main.bounds.height
    @State private var squareButtonAlpha : CGFloat = 0
    @State private var isAccountButtonPressed : Bool = false
    
    @State private var buttonOpacity : Double = 0
    
    @ObservedObject private var keyboardHelper = KeyboardHeightHelper()
    
    @EnvironmentObject var store: LoginStore
    @EnvironmentObject var appDataStore: AppDataStore
    
    private var startHeight : CGFloat = {
        262 > UIScreen.main.bounds.height * 0.4 ?
            UIScreen.main.bounds.height * 0.4 : 262
    }()
    
    private var startWidth : CGFloat = {
        243 > UIScreen.main.bounds.width * 0.6 ?
            UIScreen.main.bounds.width * 0.6 : 243
    }()
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(width: 0, height: topInset)
                    SquareView(
                        buttonAlpha: squareButtonAlpha,
                        isAccountButtonPressed: $isAccountButtonPressed
                    )
                    .frame(
                        width: isAccountButtonPressed
                            ? UIScreen.main.bounds.width - 24 : startWidth,
                        height: !keyboardHelper.isKeyboardShown ? startHeight : UIScreen.main.bounds.height -
                            keyboardHelper.keyboardHeight
                            - geometry.safeAreaInsets.top
                            - 104
                    )
                    if isAccountButtonPressed {
                        LogInButton(
                            isButtonActive: store.state.isValid
                        ) {
                            let successAction = { token in
                                appDataStore.dispatch(action: .setToken(token))
                            }
                            store.dispatch(action: .logIn(successAction))
                        }
                        .onAppear {
                            withAnimation {
                                buttonOpacity = 1
                            }
                        }
                        .opacity(buttonOpacity)
                        .padding(.top, 12)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding([.leading], 12)
            .onAppear {
                topInset = UIScreen.main.bounds.height
                    - startHeight - geometry.safeAreaInsets.bottom
                    - geometry.safeAreaInsets.top - 20
                let baseAnimation = Animation.easeInOut(duration: 0.9)
                    .delay(0.5)
                withAnimation(baseAnimation) {
                    squareButtonAlpha = 1
                    topInset = 18
                }
            }
            .onAnimationCompleted(for: topInset) {
                let animation = Animation.easeOut(duration: 1)
                squareButtonAlpha = 0
                withAnimation(animation) {
                    isAccountButtonPressed = true
                }
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
