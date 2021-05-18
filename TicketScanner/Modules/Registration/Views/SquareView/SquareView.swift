//
//  SquareView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 17.05.2021.
//

import SwiftUI

struct SquareView: View {
    
    var checkInAction : Action?
    var buttonAlpha : CGFloat
    
    init(buttonAlpha : CGFloat) {
        self.buttonAlpha = buttonAlpha
    }
    
    var body: some View {
        VStack {
            HStack {
                content
                Spacer()
            }
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(.black)
        )
        .background(Color.clear)
    }
    
    var content: some View {
        
        VStack {
            Button(
                action: {
                    checkInAction?()
                },
                label: {
                    Text("2204\nCheck in")
                        .font(Font.custom("EKRepro-2204", size: 24))
                }
            )
            .padding([.leading], 12)
            .padding([.top], 8)
            .foregroundColor(.white)
            .opacity(Double(buttonAlpha))
        }
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(buttonAlpha: 1)
    }
}
