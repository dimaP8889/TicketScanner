//
//  ManualEnterTextField.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 13.06.2021.
//

import SwiftUI

struct ManualEnterTextField: View {
    
    @Binding var text: String
    var textDidChange: Action
    
    var body: some View {
        ManualEnterTextFieldContainer(text: $text, textDidChange: textDidChange)
    }
}

struct ManualEnterTextField_Previews: PreviewProvider {
    static var previews: some View {
        ManualEnterTextField(text: .constant("lol"), textDidChange: {})
    }
}
