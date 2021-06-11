//
//  TicketMainInfoView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct TicketMainInfoView: View {
    
    let model : TicketMainInfoModel
    
    var body: some View {
        VStack(spacing: 32) {
            HStack(spacing: 0) {
                Text(model.name)
                    .font(.main(size: 17))
                    .foregroundColor(Color.codGray)
                Spacer()
                Image("ic_red_cross")
                    .padding(.trailing, 10)
                    .padding(.top, 2)
                Text(model.time)
                    .font(.main(size: 14))
                    .foregroundColor(Color.radicalRed)
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
        TicketMainInfoView(model: TicketMainInfoModel(name: "Vetralan Hampston", time: "18:54:13", ticketNumber: "1214Q67839ZX"))
    }
}
