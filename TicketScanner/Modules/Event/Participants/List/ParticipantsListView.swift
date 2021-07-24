//
//  ParticipantsListView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import SwiftUI

struct ParticipantsListView: View {
    
    var data : [ParticipantsInfoModel]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(data) { info in
                    TimeListView(data: info)
                        .padding([.leading, .trailing], 16)
                }
            }
        }
        .background(Color.white)
    }
}

struct ParticipantsListView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantsListView(data: (0...10).map{_ in ParticipantsInfoModel.random})
    }
}
