//
//  InfoFieldView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 19.05.2021.
//

import SwiftUI

struct InfoFieldView: View {
    
    var fieldType : FieldType
    
    @State private var text : String = ""
    @State private var isEditting : Bool = false
    
    @Binding var isError : Bool
    @State private var isValid : Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            field
            if !isValid || isError {
                errorText
            }
        }
        .background(Color.clear)
    }
    
    private var field: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(fieldType.description)
                    .font(.main(size: 14))
                    .foregroundColor(.alto)
                    .padding(.top, 10)
                    .padding(.leading, 16)
                Spacer()
            }
            
            CustomTextField(
                placeholder: fieldType.placeholder,
                text: $text,
                editingChanged: { isEditting in
                    self.isEditting = isEditting
                },
                isSecured: fieldType == .password
            )
            .font(.main(size: 20))
            .padding(.leading, 16)
            .padding(.trailing, 8)
        }
        .padding(.bottom, 16)
        .overlay(
            RoundedRectangle(cornerRadius: 19)
                .stroke(
                    isError || !isValid ? Color.radicalRedLight : isEditting
                            ? Color.altoLight : Color.altoSuperLight
                )
        )
    }

    private var errorText: some View {
        Text(localStr("registration.error.title"))
            .foregroundColor(.radicalRed)
            .font(.main(size: 12))
            .animation(.easeInOut(duration: 0.1))
    }
}

extension InfoFieldView {
    
    enum FieldType {
        
        case email
        case password
        
        var description : String {
            switch self {
            case .email:
                return localStr("registration.textfield.email.description")
            case .password:
                return localStr("registration.textfield.password.description")
            }
        }
        
        var placeholder : String {
            switch self {
            case .email:
                return localStr("registration.textfield.email.placeholder")
            case .password:
                return localStr("registration.textfield.password.placeholder")
            }
        }
    }
}

struct InfoFieldView_Previews: PreviewProvider {
    static var previews: some View {
        InfoFieldView(fieldType: .email, isError: .constant(false))
            .background(Color.black)
    }
}
