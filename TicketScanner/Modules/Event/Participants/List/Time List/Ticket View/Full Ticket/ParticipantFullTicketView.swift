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
        VStack {
            TicketMainInfoView(model: model.main, status: model.status, isParticipantsTicket: true)
            Spacer()
                .ticket()
            TicketSecondaryInfoView(model: model.secondary)
            Spacer()
                .frame(maxHeight: 32)
        }
    }
}

struct ParticipantFullTicketView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantFullTicketView(model: .random)
    }
}
