//
//  FullTciketView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 11.06.2021.
//

import SwiftUI

struct FullTicketView: View {
    
    let model : FullTicketModel
    
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    @GestureState private var dragOffset = CGSize.zero
    
    init(model : FullTicketModel) {
        
        self.model = model
    }
    
    var body: some View {
        
        VStack {
            TicketMainInfoView(model: model, isParticipantsTicket: false)
                .padding(.bottom, 24)
            Spacer()
                .ticket()
            TicketStatusView(model: model.status)
            Spacer()
                .ticket()
            TicketSecondaryInfoView(model: model.secondary)
                .padding(.top, 32)
            Spacer()
            HStack {
                Spacer()
                OkButton() {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding([.trailing, .bottom], 12)
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: TicketBackButton(backAction: {
                presentationMode.wrappedValue.dismiss()
            })
        )
        .background(
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(Color.galleryDark)
        )
        .padding([.trailing, .leading], 12)
        .padding([.top, .bottom], 10)
    }
}

struct FullTciketView_Previews: PreviewProvider {
    static var previews: some View {
        FullTicketView(model: .random)
    }
}
