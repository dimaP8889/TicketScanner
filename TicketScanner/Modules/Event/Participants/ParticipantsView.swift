//
//  ParticipantsView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 07.06.2021.
//

import SwiftUI

struct ParticipantsView: View {
    
    @State var searchText : String = ""
    
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
                Spacer()
            }
        }
    }
}

struct ParticipantsView_Previews: PreviewProvider {
    
    private let participantsStore = ParticipantsStore()
    
    static var previews: some View {
        ParticipantsView()
    }
}
