//
//  SearchFieldView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 05.07.2021.
//

import SwiftUI

struct SearchFieldView: View {
    
    @Binding private var text : String
    
    @EnvironmentObject
    var participantsStore : ParticipantsStore
    
    init(text: Binding<String>) {
        self._text = text
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        
        HStack(spacing: 12) {
            HStack(spacing: 9) {
                Image("ic_search")
                    .padding([.top, .bottom], 10.5)
                    .padding(.leading, 12)
                TextField(localStr("participants.search.placeholder"), text: $text)
                    .font(.main(size: 17))
                    .onChange(of: text) { value in
                        participantsStore.dispatch(action: .loadParticipants(name: value))
                    }
                Spacer(minLength: 3)
            }
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(.galleryDark)
            )
            
            if text.count > 0 {
                Button(action: {
                    text = ""
                    hideKeyboard()
                }, label: {
                    Text(localStr("participants.search.cancel"))
                        .font(.main(size: 17))
                        .foregroundColor(Color.radicalRed)
                })
            }
        }
    }
}

struct SearchFieldView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchFieldView(text: .constant(""))
    }
}
