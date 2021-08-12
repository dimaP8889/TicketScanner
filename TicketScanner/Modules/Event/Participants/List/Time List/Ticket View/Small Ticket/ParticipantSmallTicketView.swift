//
//  ParticipantSmallTicketView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import SwiftUI

struct ParticipantSmallTicketView: View {
    
    var data : FullTicketModel
    
    private var statusImage : Image {
        switch data.status {
        case .success:
            return Image("ic_success_tick")
        default:
            return Image("ic_red_cross")
        }
    }
    
    var body: some View {
        HStack(alignment : .firstTextBaseline, spacing: 0) {
            Text(data.main.name)
                .font(.main(size: 17))
                .foregroundColor(.codGray)
                .padding([.top, .bottom], 19)
                .padding(.leading, 16)
            Spacer()
            statusImage
                .padding(.trailing, 10)
            Text(data.main.time)
                .font(.main(size: 14))
                .foregroundColor(.newGray)
                .padding(.trailing, 16)
        }
    }
}

struct ParticipantSmallTicketView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantSmallTicketView(data: FullTicketModel.random)
    }
}
