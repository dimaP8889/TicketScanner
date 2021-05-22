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
                placeholder: Text(fieldType.placeholder).foregroundColor(.white.opacity(0.5)),
                text: $text,
                editingChanged: { isEditting in
                    self.isEditting = isEditting
                },
                commit: {
                    withAnimation {
                        self.isValid = text.count < 5
                    }
                },
                isSecured: fieldType == .password
            )
            .foregroundColor(.white)
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
        Text("Будь ласка, введіть справжній email або id")
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
                return "Email або id"
            case .password:
                return "Пароль"
            }
        }
        
        var placeholder : String {
            switch self {
            case .email:
                return "введіть свій email або id"
            default:
                return "введіть свій пароль"
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
