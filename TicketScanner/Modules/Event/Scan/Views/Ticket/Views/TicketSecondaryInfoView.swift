//
//  TicketSecondaryInfoView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct TicketSecondaryInfoView: View {
    
    var model: TicketSecondaryInfoModel
    
    @State private var width: CGFloat? = nil
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                
                HStack(alignment: .bottom, spacing: 24) {
                    Text(localStr("scan.ticket.type"))
                        .mainTicketStyle()
                        .frame(width: width, alignment: .leading)
                        .background(CenteringView())
                    Text(model.type)
                        .secodaryTicketStyle()
                        .padding(.top, 2)
                }
                HStack(alignment: .bottom, spacing: 24) {
                    Text(localStr("scan.ticket.phone"))
                        .mainTicketStyle()
                        .frame(width: width, alignment: .leading)
                        .background(CenteringView())
                    Text(model.number)
                        .secodaryTicketStyle()
                        .padding(.top, 2)
                }
                HStack(alignment: .bottom, spacing: 24) {
                    Text(localStr("scan.ticket.email"))
                        .mainTicketStyle()
                        .frame(width: width, alignment: .leading)
                        .background(CenteringView())
                    Text(model.email)
                        .secodaryTicketStyle()
                        .padding(.top, 2)
                }
            }
            .onPreferenceChange(CenteringColumnPreferenceKey.self) { preferences in
                for p in preferences {
                    let oldWidth = self.width ?? CGFloat.zero
                    if p.width > oldWidth {
                        self.width = p.width
                    }
                }
            }
            Spacer()
        }
        .padding(.leading, 16)
    }
}

struct TicketSecondaryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TicketSecondaryInfoView(model: TicketSecondaryInfoModel(type: "1 DAY TICKET: 21/08", number: "+38 067 3****11", email: "jax**********76@yahoo.com"))
    }
}
