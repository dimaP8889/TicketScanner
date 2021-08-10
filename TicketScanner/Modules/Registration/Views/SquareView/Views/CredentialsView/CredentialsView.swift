//
//  CredentialsView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 19.05.2021.
//

import SwiftUI

struct CredentialsView: View {
    
    @EnvironmentObject private var store: LoginStore
    
    private var isNeedShowError : Bool {
        store.state.isError
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(localStr("registration.square.title"))
                    .font(Font.main(size: 24))
                    .foregroundColor(.alto)
                    .padding(.leading, 12)
                    .padding(.top, 8)
                Spacer()
            }
            Spacer()
            InfoFieldView(fieldType: .email)
                .padding(.leading, 12)
                .padding(.trailing, 12)
                .frame(height: 73)
            InfoFieldView(fieldType: .password)
                .padding(.leading, 12)
                .padding(.trailing, 12)
                .frame(height: 73)
            if isNeedShowError {
                errorText
                    .padding(.top, -6)
                    .padding(.leading, 16)
            }
        }
        .padding(.bottom, 16)
    }
    
    private var errorText: some View {
        Text(localStr("registration.error.title"))
            .foregroundColor(.radicalRed)
            .font(.main(size: 12))
    }
}

struct CredentialsView_Previews: PreviewProvider {
    static var previews: some View {
        CredentialsView()
            .background(Color.black)
    }
}
