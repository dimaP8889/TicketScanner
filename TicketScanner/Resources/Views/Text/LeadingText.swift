//
//  LeadingText.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct LeadingText: View {
    
    var text: Text

    var body: some View {
        
        HStack {
            text
            Spacer()
        }
    }
}
