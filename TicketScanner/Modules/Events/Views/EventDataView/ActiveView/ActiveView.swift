//
//  ActiveView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.06.2021.
//

import SwiftUI

struct ActiveView: View {
    var body: some View {
        Text(localStr("events.active.title"))
            .font(.main(size: 14))
            .foregroundColor(.apple)
            .padding([.leading, .trailing], 16)
            .padding(.top, 7)
            .padding(.bottom, 10)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(Color.screaminGreen)
            )
    }
}

struct ActiveView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveView()
    }
}
