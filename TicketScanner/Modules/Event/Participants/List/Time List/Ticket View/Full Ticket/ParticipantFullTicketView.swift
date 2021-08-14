//
//  ParticipantFullTicketView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import SwiftUI

struct ParticipantFullTicketView: View {
    
    let model : FullTicketModel
    
    var body: some View {
        VStack(spacing: 0) {
            TicketMainInfoView(model: model, isParticipantsTicket: true)
            TicketStatusView(model: model.status)
            Spacer()
                .ticket()
            TicketSecondaryInfoView(model: model.secondary)
                .padding(.top, 20)
            Spacer()
                .frame(minHeight: 32)
        }
    }
}

struct ParticipantFullTicketView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantFullTicketView(model: .random)
    }
}
