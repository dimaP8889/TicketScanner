//
//  CustomTextField.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.05.2021.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    
    var placeholder: String
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var isSecured : Bool

    var body: some View {
        CustomTextFieldContainer(placeholder: placeholder, isSecure: isSecured, text: $text, editingChanged: editingChanged)
    }
}
