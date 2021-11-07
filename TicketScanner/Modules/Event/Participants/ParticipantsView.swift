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
    var participantsStore : Store<ParticipantsModel, ParticipantsAction>
    
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
                ParticipantsListView()
            }
        }
        .onAppear {
            participantsStore.send(.loadParticipants)
        }
    }
}

struct ParticipantsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ParticipantsView()
    }
}
