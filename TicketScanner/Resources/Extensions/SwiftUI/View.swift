//
//  View.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

extension View {
    
    func showPopup(alertModel: AlertModel?, swipeAction: @escaping Action) -> some View {
        ZStack {
            self
            if let model = alertModel {
                AlertView(model: model, swipeAction: swipeAction)
                    .transition(.move(edge: .top))
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 19))
    }
}
