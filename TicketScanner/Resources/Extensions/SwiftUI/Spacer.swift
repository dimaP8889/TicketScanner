//
//  Spacer.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

extension Spacer {
    
    func ticket() -> some View {
        self
            .frame(
                maxWidth: .infinity,
                maxHeight: 1
            )
            .background(Color.black.opacity(0.05))
            .padding([.leading, .trailing], 16)
    }
}
