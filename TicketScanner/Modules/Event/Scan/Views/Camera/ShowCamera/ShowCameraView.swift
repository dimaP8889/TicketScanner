//
//  ShowCameraView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 13.06.2021.
//

import SwiftUI

struct ShowCameraView: View {
    
    var pressAction : Action
    
    var body: some View {
        
        Button(
            action: {
                pressAction()
            },
            label: {
            HStack(spacing: 12) {
                Image("ic_scan")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.codGray)
                    .frame(width: 17, height: 17)
                Text(localStr("scan.camera.title"))
                    .font(.main(size: 17))
                    .foregroundColor(.codGray)
            }
            .padding([.top, .bottom], 21)
            .padding([.leading, .trailing], 37.5)
        })
        .background(
            RoundedRectangle(cornerRadius: 14)
                .foregroundColor(.galleryDark)
        )
    }
}

struct ShowCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ShowCameraView(pressAction: {})
    }
}
