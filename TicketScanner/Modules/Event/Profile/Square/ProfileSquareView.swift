//
//  ProfileSquareView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.07.2021.
//

import SwiftUI

struct ProfileSquareView: View {
    
    private var sideLength : CGFloat = UIScreen.main.bounds.width - 24
    private var user = {
        Defaults.shared.defaultUser ?? "not found"
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(localStr("profile.title"))
                .font(.main(size: 24))
                .foregroundColor(.alto)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .padding(.top, 8)
            Spacer()
            Text(localStr("profile.controller"))
                .font(.main(size: 14))
                .foregroundColor(.altoLight)
                .padding(.leading, 16)
            Text(user)
                .font(.main(size: 20))
                .foregroundColor(.alto)
                .padding(.leading, 16)
                .padding(.bottom, 40)
        }
        .frame(width: sideLength, height: sideLength)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(.codGray)
        )
    }
}

struct ProfileSquareView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSquareView()
    }
}
