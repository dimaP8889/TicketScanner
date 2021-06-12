//
//  AlertContentView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct AlertContentView: View {
    
    var model : AlertModel = AlertModel.test
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(model.alertType.result)
                    .font(.main(size: 17))
                    .foregroundColor(model.alertType.topTexColor)
                Spacer()
                Text(model.time)
                    .font(.main(size: 17))
                    .foregroundColor(model.alertType.topTexColor)
            }
            .padding([.leading, .trailing], 16)
            .padding(.top, 12)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 0) {
                Image(model.alertType.resultIcon)
                    .padding(.trailing, 12)
                    .padding(.top, 2)
                Text(model.alertType.mainText)
                    .font(.main(size: 17))
                    .foregroundColor(Color.codGray)
                Spacer()
            }
            .padding([.leading, .trailing], 16)
            .padding(.bottom, 16)
        }
        .background(
            RoundedRectangle(cornerRadius: 19)
                .foregroundColor(model.alertType.alertColor)
        )
    }
}

struct AlertContentView_Previews: PreviewProvider {
    static var previews: some View {
        AlertContentView()
            .frame(maxHeight: 70)
    }
}
