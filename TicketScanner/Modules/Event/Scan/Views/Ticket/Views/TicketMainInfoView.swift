//
//  TicketMainInfoView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct TicketMainInfoView: View {
    
    let model : FullTicketModel
    let isParticipantsTicket : Bool
    
    private var statusImage : Image {
        switch model.status {
        case .success:
            return Image("ic_success_tick")
        default:
            return Image("ic_red_cross")
        }
    }
    
    private var timeTextColor : Color {
        isParticipantsTicket ? .newGray : Color.radicalRed
    }
    
    var body: some View {
        VStack(spacing: 32) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text(model.main.name)
                    .font(.main(size: 17))
                    .foregroundColor(Color.codGray)
                Spacer()
                statusImage
                    .padding(.trailing, 10)
                Text(model.main.time)
                    .font(.main(size: 14))
                    .foregroundColor(timeTextColor)
            }
            HStack(spacing: 8) {
                Text("#")
                    .font(.main(size: 20))
                    .foregroundColor(Color.codGray)
                Text(model.main.ticketNumber)
                    .font(.main(size: 20))
                    .foregroundColor(Color.codGray)
                Spacer()
            }
        }
        .padding(.top, 19)
        .padding([.leading, .trailing], 16)
        .padding(.bottom, 24)
        .background(Color.clear)
    }
}

struct TicketMainInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TicketMainInfoView(model: .random, isParticipantsTicket: true)
    }
}
