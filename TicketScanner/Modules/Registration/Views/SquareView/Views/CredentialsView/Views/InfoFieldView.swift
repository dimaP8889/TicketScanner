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
    
    var body: some View {
        VStack {
            field
        }
    }
    
    private var field: some View {
        VStack {
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
                text: $text
            )
            .font(.main(size: 20))
            .padding(.leading, 16)
            .padding(.trailing, 8)
            .padding(.top, 6)
            .padding(.bottom, 16)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 19)
                .stroke(Color.altoSuperLight)
        )
        .background(Color.black)
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
        InfoFieldView(fieldType: .password)
    }
}
