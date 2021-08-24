//
//  CheckInView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 19.05.2021.
//

import SwiftUI

struct CheckInView: View {
    
    var alpha : CGFloat
    
    var body: some View {
        VStack {
            HStack {
                content
                Spacer()
            }
            Spacer()
        }
        .background(Color.clear)
    }
    
    var content: some View {
        
        VStack {
            Text(localStr("registration.button.check-in"))
                .font(.main(size: 24))
                .padding([.leading], 12)
                .padding([.top], 8)
                .foregroundColor(.white)
                .opacity(Double(alpha))
        }
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView(alpha: 100)
            .background(Color.black)
    }
}
