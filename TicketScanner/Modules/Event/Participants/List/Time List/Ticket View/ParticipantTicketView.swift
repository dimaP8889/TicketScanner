//
//  ParticipantTicketView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import SwiftUI

struct ParticipantTicketView: View {
    
    var data : FullTicketModel
    private var isOpened : Bool
    
    @EnvironmentObject
    var participantsStore : ParticipantsStore
    
    init(data : FullTicketModel, isOpened : Bool) {
        self.isOpened = isOpened
        self.data = data
    }
    
    var body: some View {
        ZStack {
            if isOpened {
                ParticipantFullTicketView(model: data)
            } else {
                ParticipantSmallTicketView(data: data)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(.gallery)
        )
        .onTapGesture {
            isOpened ?
                participantsStore.dispatch(action: .closeTicket) :
                participantsStore.dispatch(action: .openTicket(hash: data.ticketId))
        }
    }
}

struct ParticipantTicketView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantTicketView(data: FullTicketModel.random, isOpened: true)
    }
}
