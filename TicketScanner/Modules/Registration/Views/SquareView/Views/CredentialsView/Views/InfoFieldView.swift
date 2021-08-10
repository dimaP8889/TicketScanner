//
//  InfoFieldView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 19.05.2021.
//

import SwiftUI

struct InfoFieldView: View {
    
    var fieldType : FieldType
    
    @EnvironmentObject private var store: LoginStore
    
    @State private var isHiden = true
    
    @State private var text : String = ""
    @State private var isEditting : Bool = false
    
    private var isErrorState : Bool {
        store.state.isError
    }
    
    private var trailingPadding : CGFloat {
        UIScreen.main.bounds.width - 243
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            field
        }
        .background(Color.clear)
        .padding(
            .trailing,
            isHiden ? trailingPadding : 0
        )
        .onAppear {
            withAnimation(.easeOut(duration: 1)) {
                isHiden = false
            }
        }
    }
}

// MARK: - Private Properties
private extension InfoFieldView {
    
    var field: some View {
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
                textDidChange: {
                    store.dispatch(
                        action:
                            fieldType == .password
                            ? .changePassword(text)
                            : .changeEmail(text)
                    )
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
                    isErrorState ? Color.radicalRedLight : isEditting
                            ? Color.altoLight : Color.altoSuperLight
                )
        )
    }
}

// MARK: - Model
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
        InfoFieldView(fieldType: .email)
            .background(Color.black)
    }
}
