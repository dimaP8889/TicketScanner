//
//  TicketBackButton.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 14.06.2021.
//

import SwiftUI

struct TicketBackButton: View {
    
    var backAction : Action
    
    var body: some View {
        Button(action: {
            backAction()
        }, label: {
            HStack(spacing: 0) {
                Image("ic_back_arrow")
                    .padding(.trailing, 12)
                Text("Сканувати")
                    .font(.main(size: 20))
                    .foregroundColor(.codGray)
            }
        })
    }
}

struct TicketBackButton_Previews: PreviewProvider {
    static var previews: some View {
        TicketBackButton(backAction: {})
    }
}
