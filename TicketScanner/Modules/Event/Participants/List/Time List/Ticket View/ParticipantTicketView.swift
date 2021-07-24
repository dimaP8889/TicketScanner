//
//  ParticipantTicketView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import SwiftUI

struct ParticipantTicketView: View {
    
    var data : FullTicketModel
    @State private var isOpened : Bool = false
    
    init(data : FullTicketModel) {
        self.data = data
    }
    
    var body: some View {
        ZStack {
            if isOpened {
                ParticipantFullTicketView(model: data)
            } else {
                ParticipantSmallTicketView(data: data)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(.gallery)
        )
        .onTapGesture {
            isOpened.toggle()
        }
    }
}

struct ParticipantTicketView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantTicketView(data: FullTicketModel.random)
    }
}
