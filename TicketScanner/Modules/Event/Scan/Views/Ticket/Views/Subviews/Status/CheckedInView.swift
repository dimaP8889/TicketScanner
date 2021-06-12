//
//  CheckedInView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

extension TicketStatusView {
    
    struct CheckedInView: View {
        
        var time : String
        var date : String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(localStr("scan.error.checked_in"))
                        .font(.main(size: 17))
                        .foregroundColor(Color.radicalRed)
                    Spacer()
                }
                HStack(spacing: 16) {
                    Image("ic_clock2")
                    Text(time)
                        .mainTicketStyle()
                    Text(date)
                        .mainTicketStyle()
                }
            }
            .padding([.leading, .trailing], 16)
            .padding([.top, .bottom], 24)
            .background(Color.clear)
        }
    }
}

struct CheckedInView_Previews: PreviewProvider {
    static var previews: some View {
        TicketStatusView.CheckedInView(time: "23:46:19", date: "21 серпня, 2021")
    }
}
