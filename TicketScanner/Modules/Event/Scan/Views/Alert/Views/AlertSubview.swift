//
//  AlertSubview.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct AlertSubview: View {
    
    var model : AlertSubviewModel
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                if let title = model.title {
                    Text(title)
                        .font(.main(size: 14))
                        .foregroundColor(.codGray)
                }
                
                Spacer()
                
                if model.isTicket {
                    ticketView
                }
            }
            .padding([.trailing, .leading], 16)
            .padding(.bottom, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 19)
                .foregroundColor(.gallery)
        )
        
    }
    
    var ticketView : some View {
        HStack(spacing: 6) {
            Image("ic_info_ticket")
            Text(localStr("alert.ticket.name"))
                .font(.main(size: 14))
                .foregroundColor(.codGray)
        }
    }
}

struct AlertSubview_Previews: PreviewProvider {
    static var previews: some View {
        AlertSubview(model: .test)
            .frame(maxHeight: 70)
    }
}
