//
//  View.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

extension View {
    
    func showPopup(alertObject: AlertObject) -> some View {
        ZStack {
            self
            if let model = alertObject.alertModel {
                AlertView(model: model)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 19))
    }
}
