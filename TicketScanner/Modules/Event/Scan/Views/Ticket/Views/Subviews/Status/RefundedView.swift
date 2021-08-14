//
//  RefundedView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

extension TicketStatusView {
    
    struct RefundedView: View {
        
        var date : String?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(localStr("scan.error.refunded"))
                        .font(.main(size: 17))
                        .foregroundColor(Color.radicalRed)
                    Spacer()
                }
                if date != nil {
                    HStack(spacing: 16) {
                        Image("ic_clock2")
                            .padding(.top, 2)
                        Text(date!)
                            .mainTicketStyle()
                    }
                }
            }
            .padding([.leading, .trailing], 16)
            .padding([.top, .bottom], 24)
            .background(Color.clear)
        }
    }
}

struct RefundedView_Previews: PreviewProvider {
    static var previews: some View {
        TicketStatusView.RefundedView(date: "21 серпня, 2021")
    }
}
