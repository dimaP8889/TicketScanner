//
//  ManualEnterView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 13.06.2021.
//

import SwiftUI

struct ManualEnterView: View {
    
    @State private var text: String = ""
    
    var codeAction : TypeAction<String>
    
    var body: some View {
        
        VStack {
            Spacer()
            VStack(spacing: 12) {
                LeadingText(
                    text: Text(localStr("scan.manual.enter.description"))
                                .mainTicketStyle()
                )
                HStack(alignment: .center) {
                    Spacer()
                    TextField("", text: $text)
                        .font(.main(size: 28))
                        .foregroundColor(.codGray)
                        .multilineTextAlignment(.center)
                        .padding([.top, .bottom], 22)
                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .foregroundColor(.white)
                )
            }
            .padding([.leading, .trailing], 12)
            Spacer()
            HStack {
                ShowCameraView(pressAction: {})
                Spacer()
            }
            .padding([.leading, .bottom], 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(.alto)
        )
    }
}

struct ManualEnterView_Previews: PreviewProvider {
    static var previews: some View {
        ManualEnterView(codeAction: {_ in})
    }
}
