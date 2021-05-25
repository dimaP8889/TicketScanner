//
//  CustomTextFieldSwift.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 26.05.2021.
//

import Foundation
import SwiftUI

struct CustomTextFieldContainer: UIViewRepresentable {
    
    private var placeholder : String
    private var isSecure : Bool
    private var text : Binding<String>
    private var editingChanged: (Bool)->() = { _ in }
    
    init(
        placeholder: String, isSecure: Bool,
        text: Binding<String>, editingChanged: @escaping (Bool) -> ()
    ) {
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.text = text
        self.editingChanged = editingChanged
    }
    
    

    func makeCoordinator() -> CustomTextFieldContainer.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<CustomTextFieldContainer>) -> UITextField {

        let innertTextField = UITextField(frame: .zero)
        
        innertTextField.attributedPlaceholder =
            NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
            )
        
        innertTextField.text = text.wrappedValue
        innertTextField.delegate = context.coordinator
        innertTextField.isSecureTextEntry = isSecure
        
        if !isSecure {
            innertTextField.keyboardType = .emailAddress
            innertTextField.autocorrectionType = .no
            innertTextField.autocapitalizationType = .none
        }
        
        context.coordinator.setup(innertTextField)

        return innertTextField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextFieldContainer>) {
        uiView.text = self.text.wrappedValue
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        
        var parent: CustomTextFieldContainer

        init(_ customTextFieldContainer: CustomTextFieldContainer) {
            self.parent = customTextFieldContainer
        }
        
        func setup(_ textField:UITextField) {
            textField.textColor = .white
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            self.parent.text.wrappedValue = textField.text ?? ""
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.editingChanged(true)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.editingChanged(false)
        }
    }
}
