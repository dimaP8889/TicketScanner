//
//  TicketStatusView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct TicketStatusView: View {
    
    let model : TicketStatus
    
    var body: some View {
        
        switch model {
        case let .refunded(time):
            RefundedView(date: time)
        case let .checkedIn(time, date):
            CheckedInView(time: time, date: date)
        case let .wrongEvent(name, time):
            WrongEventView(festivalName: name, date: time)
        case .success:
            EmptyView()
        }
    }
}

struct TicketStatusView_Previews: PreviewProvider {
    static var previews: some View {
        TicketStatusView(model: TicketStatus.random)
    }
}
