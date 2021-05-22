//
//  CredentialsView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 19.05.2021.
//

import SwiftUI

struct CredentialsView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Вхід")
                    .font(Font.main(size: 14))
                    .foregroundColor(.alto)
                    .padding(.leading, 12)
                    .padding(.top, 8)
                Spacer()
            }
            Spacer()
            InfoFieldView(fieldType: .email, isError: .constant(false))
            InfoFieldView(fieldType: .password, isError: .constant(false))
        }
        .background(Color.black)
    }
}

struct CredentialsView_Previews: PreviewProvider {
    static var previews: some View {
        CredentialsView()
    }
}
