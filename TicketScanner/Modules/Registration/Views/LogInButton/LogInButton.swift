//
//  LogInButton.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 22.05.2021.
//

import SwiftUI

struct LogInButton: View {
    
    // Create Enviromental oblect for button state
    
    var buttonPressAction : Action
    
    var body: some View {
        Button("Увійти") {
            
        }
    }
}

struct LogInButton_Previews: PreviewProvider {
    static var previews: some View {
        LogInButton(buttonPressAction: {})
    }
}
