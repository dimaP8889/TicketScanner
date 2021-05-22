//
//  CredentialsView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 19.05.2021.
//

import SwiftUI

struct CredentialsView: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("Вхід")
                    .font(Font.main(size: 14))
                    .foregroundColor(.alto)
                    .padding(.leading, 12)
                    .padding(.top, 8)
                Spacer()
            }
            Spacer()
        }
        .background(Color.clear)
    }
}

struct CredentialsView_Previews: PreviewProvider {
    static var previews: some View {
        CredentialsView()
    }
}
