//
//  CustomTextField.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.05.2021.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
