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
    var isSecured : Bool

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            if isSecured {
                SecureField("", text: $text)
                    .onChange(of: text) { value in
                        editingChanged(text != "")
                    }
            } else {
                TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
            }
        }
    }
}
