//
//  ManualEnterTextField.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 13.06.2021.
//

import SwiftUI

struct ManualEnterTextFieldContainer: UIViewRepresentable {
    
    private var text : Binding<String>
    private var textDidChange: Action
    
    init(
        text: Binding<String>,
        textDidChange: @escaping Action
    ) {
        self.text = text
        self.textDidChange = textDidChange
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<ManualEnterTextFieldContainer>) -> UITextField {

        let innertTextField = UITextField(frame: .zero)
        
        innertTextField.text = text.wrappedValue
        innertTextField.delegate = context.coordinator
        if !innertTextField.isFirstResponder {
            innertTextField.becomeFirstResponder()
        }
        context.coordinator.setup(innertTextField)

        return innertTextField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<ManualEnterTextFieldContainer>) {
        uiView.text = self.text.wrappedValue
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        
        var parent: ManualEnterTextFieldContainer

        init(_ customTextFieldContainer: ManualEnterTextFieldContainer) {
            self.parent = customTextFieldContainer
        }
        
        func setup(_ textField:UITextField) {
            textField.textColor = UIColor(.codGray)
            textField.font = UIFont(name: "EKRepro-2204", size: 28)
            textField.textAlignment = .center
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .decimalPad
            textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            self.parent.text.wrappedValue = String((textField.text ?? ""))
            self.parent.textDidChange()
        }
    }
}
