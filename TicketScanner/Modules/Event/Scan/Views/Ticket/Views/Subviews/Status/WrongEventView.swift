//
//  WrongEventView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

extension TicketStatusView {
    struct WrongEventView: View {
        
        var festivalName : String
        var date : String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                LeadingText(
                    text: Text(localStr("scan.error.refunded"))
                        .font(.main(size: 17))
                        .foregroundColor(Color.radicalRed)
                )
                Text(localStr("scan.error.wrong_event.secondary"))
                    .mainTicketStyle()
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                Text(festivalName)
                    .secodaryTicketStyle()
                    .padding(.bottom, 2)
                Text(date)
                    .secodaryTicketStyle()
            }
            .padding([.leading, .trailing], 16)
            .padding([.top, .bottom], 24)
            .background(Color.clear)
        }
    }
}

struct WrongEventView_Previews: PreviewProvider {
    static var previews: some View {
        TicketStatusView.WrongEventView(festivalName: "Uncertain Festival Official Afterparty @ K41", date: "22 серпня 2021")
    }
}
