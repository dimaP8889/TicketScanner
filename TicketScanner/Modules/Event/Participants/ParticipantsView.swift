//
//  ParticipantsView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 07.06.2021.
//

import SwiftUI

struct ParticipantsView: View {
    
    @State var searchText : String = ""
    
    @EnvironmentObject
    var participantsStore : ParticipantsStore
    
    var body: some View {
        ZStack {
            Color.alabaster.ignoresSafeArea()
            VStack {
                VStack(spacing: 12) {
                    SearchFieldView(text: $searchText)
                    FilterView()
                }
                .padding([.leading, .trailing], 12)
                .padding(.top, 16)
                ParticipantsListView(data: participantsStore.participants)
            }
        }
        .onAppear {
            participantsStore.dispatch(
                action: .loadParticipants
            )
        }
    }
}

struct ParticipantsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ParticipantsView()
    }
}
