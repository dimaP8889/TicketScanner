//
//  SearchFieldView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 05.07.2021.
//

import SwiftUI

struct SearchFieldView: View {
    
    @Binding var text : String
    
    var body: some View {
        
        HStack(spacing: 9) {
            Image("ic_search")
                .padding([.top, .bottom], 10.5)
                .padding(.leading, 12)
            TextField(localStr("participants.search.placeholder"), text: $text)
                .font(.main(size: 17))
            Spacer(minLength: 3)
        }
        .background(
            RoundedRectangle(cornerRadius: 14)
                .foregroundColor(.galleryDark)
        )
    }
}

struct SearchFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFieldView(text: .constant(""))
    }
}
