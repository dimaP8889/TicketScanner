//
//  TimeListView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import SwiftUI

struct TimeListView: View {
    
    var data : ParticipantsInfoModel
    
    var body: some View {
        LazyVStack(spacing: 0) {
            HStack {
                Spacer()
                Text(data.time)
                    .font(.main(size: 14))
                    .foregroundColor(.codGray)
                    .padding(.top, 6)
                    .padding(.bottom, 6)
                    .padding(.trailing, 16)
            }
            ForEach(data.tickets) { ticket in
                ParticipantTicketView(data: ticket)
                    .padding([.top, .bottom], 2)
            }
        }
        .padding(.top, 2)
    }
}

struct TimeListView_Previews: PreviewProvider {
    static var previews: some View {
        TimeListView(data: ParticipantsInfoModel.random)
    }
}
