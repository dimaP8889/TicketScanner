//
//  ParticipantsListView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import SwiftUI

struct ParticipantsListView: View {
    
    @EnvironmentObject
    var participantsStore : Store<ParticipantsModel, ParticipantsAction>
    
    init() {
        UIScrollView.appearance().keyboardDismissMode = .onDrag
    }
    
    var body: some View {
        ParticipantsTableView(
            participants: participantsStore.state.participants,
            openedTicket: participantsStore.state.openedTicked
        ) { id in
            participantsStore.send(.openTicket(hash: id))
        }
        .background(Color.white)
    }
}

struct ParticipantsListView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantsListView()
    }
}
