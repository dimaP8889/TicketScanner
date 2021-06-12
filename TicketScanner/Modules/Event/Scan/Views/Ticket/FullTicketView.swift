//
//  FullTciketView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 11.06.2021.
//

import SwiftUI

struct FullTicketView: View {
    
    let model : FullTicketModel = .random
    
    var body: some View {
        
        VStack {
            TicketMainInfoView(model: model.main)
            Spacer()
                .ticket()
            TicketStatusView(model: model.status)
            Spacer()
                .ticket()
            TicketSecondaryInfoView(model: model.secondary)
            Spacer()
            HStack {
                Spacer()
                OkButton() {}
            }
            .padding([.trailing, .bottom], 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(Color.gallery)
        )
    }
}

struct FullTciketView_Previews: PreviewProvider {
    static var previews: some View {
        FullTicketView()
    }
}
