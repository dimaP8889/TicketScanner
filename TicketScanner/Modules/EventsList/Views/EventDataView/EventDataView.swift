//
//  EventDataView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.06.2021.
//

import SwiftUI

struct EventDataView: View {
    
    var model : EventModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.dates)
                .font(.main(size: 14))
                .foregroundColor(model.isOpened ? .newGray : .codGrayTransparent2)
                .padding(.top, 12)
                .padding(.leading, 16)
            Spacer()
                .frame(height: 4)
            Text(model.festivalName)
                .font(.main(size: 20))
                .foregroundColor(model.isOpened ? .codGray : .newGray)
                .padding(.leading, 16)
            Spacer()
                .frame(height: 32)
            HStack(spacing: 8) {
                Image("ic_clock")
                    .opacity(model.isOpened ? 1 : 0.6)
                Text(model.timeToStart)
                    .font(.main(size: 14))
                    .foregroundColor(model.isOpened ? .codGray : .newGray)
                Spacer()
                if model.isActive {
                    ActiveView()
                }
            }
            .padding(.bottom, 12)
            .padding(.leading, 16)
            .padding(.trailing, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(model.isOpened ? .galleryDark : .alabaster)
        )
    }
}

struct EventDataView_Previews: PreviewProvider {
    static var previews: some View {
        EventDataView(model: .init(id: "", startDate: Date(), endDate: Date(), festivalName: "Lol"))
    }
}
