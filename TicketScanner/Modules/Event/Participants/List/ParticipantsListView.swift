//
//  ParticipantsListView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import SwiftUI

struct ParticipantsListView: View {
    
    @EnvironmentObject
    var participantsStore : ParticipantsStore
    
    init() {
        UIScrollView.appearance().keyboardDismissMode = .onDrag
    }
    
    var body: some View {
        ParticipantsTableView(
            participants: participantsStore.participants,
            openedTicket: participantsStore.openedTicket
        ) { id in
            participantsStore.dispatch(action: .openTicket(hash: id))
        }
        .background(Color.white)
    }
}

struct ParticipantsListView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantsListView()
    }
}
