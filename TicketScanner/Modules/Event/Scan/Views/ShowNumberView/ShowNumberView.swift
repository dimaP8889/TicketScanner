//
//  ShowNumberView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 08.06.2021.
//

import SwiftUI

struct ShowNumberView: View {
    
    private var width = UIScreen.main.bounds.width - 24
    
    var tapAction : Action
    
    init(tapAction : @escaping Action) {
        self.tapAction = tapAction
    }
    
    var body: some View {
        
        Button(
            action: {
                tapAction()
            },
            label: {
                HStack(spacing: 12) {
                    Image("ic_keyboard")
                    Text(localStr("scan.enter.number.title"))
                        .font(.main(size: 17))
                        .foregroundColor(.mineShaft)
                }
                .frame(width: width, height: 62)
            }
        )
        .background(
            RoundedRectangle(cornerRadius: 14)
                .foregroundColor(.galleryDark)
        )
    }
}

struct ShowNumberView_Previews: PreviewProvider {
    static var previews: some View {
        ShowNumberView(tapAction: {})
    }
}
