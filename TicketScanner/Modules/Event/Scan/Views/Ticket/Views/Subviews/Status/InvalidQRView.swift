//
//  InvalidQRView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 14.08.2021.
//


import SwiftUI

extension TicketStatusView {
    
    struct InvalidQRView: View {
        
        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(localStr("scan.error.invalidQR"))
                        .font(.main(size: 17))
                        .foregroundColor(Color.radicalRed)
                    Spacer()
                }
            }
            .padding([.leading, .trailing], 16)
            .padding([.top, .bottom], 24)
            .background(Color.clear)
        }
    }
}

struct InvalidQRView_Previews: PreviewProvider {
    static var previews: some View {
        TicketStatusView.InvalidQRView()
    }
}
