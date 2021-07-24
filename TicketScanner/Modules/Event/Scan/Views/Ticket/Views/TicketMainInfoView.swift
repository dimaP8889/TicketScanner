//
//  TicketMainInfoView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct TicketMainInfoView: View {
    
    let model : TicketMainInfoModel
    let status : TicketStatus
    let isParticipantsTicket : Bool
    
    private var statusImage : Image {
        switch status {
        case .checkedIn:
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
                Text(model.name)
                    .font(.main(size: 17))
                    .foregroundColor(Color.codGray)
                Spacer()
                statusImage
                    .padding(.trailing, 10)
                Text(model.time)
                    .font(.main(size: 14))
                    .foregroundColor(timeTextColor)
            }
            HStack(spacing: 8) {
                Text("#")
                    .font(.main(size: 20))
                    .foregroundColor(Color.codGray)
                Text(model.ticketNumber)
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
        TicketMainInfoView(model: TicketMainInfoModel(name: "Vetralan Hampston", time: "18:54:13", ticketNumber: "1214Q67839ZX"), status: .random, isParticipantsTicket: Bool.random())
    }
}
