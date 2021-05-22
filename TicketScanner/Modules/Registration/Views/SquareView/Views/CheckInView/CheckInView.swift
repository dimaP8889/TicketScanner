//
//  CheckInView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 19.05.2021.
//

import SwiftUI

struct CheckInView: View {
    
    var buttonAlpha : CGFloat
    var pressAction : Action?
    
    init(buttonAlpha : CGFloat, pressAction : Action?) {
        self.buttonAlpha = buttonAlpha
        self.pressAction = pressAction
    }
    
    var body: some View {
        VStack {
            HStack {
                content
                Spacer()
            }
            Spacer()
        }
        .background(Color.clear)
    }
    
    var content: some View {
        
        VStack {
            Button(
                action: {
                    pressAction?()
                },
                label: {
                    Text("2204\nCheck in")
                        .font(.main(size: 24))
                }
            )
            .padding([.leading], 12)
            .padding([.top], 8)
            .foregroundColor(.white)
            .opacity(Double(buttonAlpha))
        }
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView(buttonAlpha: 100, pressAction: nil)
            .background(Color.black)
    }
}
