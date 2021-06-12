//
//  OkButtonView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct OkButton: View {
    
    var buttonAction : Action
    
    var body: some View {
        Button(
            action: {
                buttonAction()
            },
            label: {
            Text(localStr("ok"))
                .foregroundColor(.white)
                .font(.main(size: 17))
                .padding([.trailing, .leading], 24)
                .padding([.top, .bottom], 21)
        })
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(.codGray)
            )
    }
}

struct OkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        OkButton() {
            
        }
    }
}
