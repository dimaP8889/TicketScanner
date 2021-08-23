//
//  ParticipantsListView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import SwiftUI

struct ParticipantsListView: View {
    
    var data : [ParticipantsInfoModel]
    
    init(data : [ParticipantsInfoModel]) {
        self.data = data
        UIScrollView.appearance().keyboardDismissMode = .onDrag
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(data) { info in
                    TimeListView(data: info)
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
