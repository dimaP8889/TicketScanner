//
//  EventsBackButton.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 07.06.2021.
//

import SwiftUI

struct EventsBackButton: View {
    
    var backAction : Action
    var title : String
    @Binding var subtitle : String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: {
                backAction()
            }, label: {
                Text("<- \(title)")
                    .font(.main(size: 14))
                    .foregroundColor(.newGray)
            })
            Text(subtitle)
                .font(.main(size: 20))
                .foregroundColor(.codGray)
        }
    }
}

struct EventsBackButton_Previews: PreviewProvider {
    static var previews: some View {
        EventsBackButton(backAction: {}, title: "Lol", subtitle: .constant("Lol"))
    }
}
