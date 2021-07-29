//
//  Text.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

extension Text {
    
    func mainTicketStyle() -> Text {
        self
            .font(.main(size: 14))
            .foregroundColor(Color.doveGray)
    }
    
    func secodaryTicketStyle() -> Text {
        self
            .font(.main(size: 14))
            .foregroundColor(.codGray)
    }
}
