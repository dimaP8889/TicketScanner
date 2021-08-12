//
//  FilterView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.07.2021.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject
    var participantsStore : ParticipantsStore
    
    var body: some View {
        HStack(spacing: 8) {
            allCell
            successCell
            failureCell
        }
    }
    
    private var allCell: some View {
        
        HStack {
            Spacer()
                .frame(width: 24)
            Text(localStr("participants.search.filter.all"))
                .foregroundColor(
                    participantsStore.state.filter == .all
                        ? .titleBlue : .codGray
                )
                .font(.main(size: 14))
                .padding([.top, .bottom], 8)
            Spacer()
                .frame(width: 24)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(
                    participantsStore.state.filter == .all ?
                        .titleBlueLight : .galleryDark
                )
        )
        .onTapGesture {
            participantsStore.dispatch(action: .changeType(to: .all))
        }
    }
    
    private var successCell: some View {
        
        HStack {
            Spacer()
            Image("ic_res_success")
                .resizable()
                .frame(width: 13, height: 9)
                .padding(.bottom, -2)
            Text(localStr("participants.search.filter.success"))
                .foregroundColor(.codGray)
                .font(.main(size: 14))
                .padding([.top, .bottom], 8)
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(
                    participantsStore.state.filter == .success ?
                        .screaminGreen : .galleryDark
                )
        )
        .onTapGesture {
            participantsStore.dispatch(action: .changeType(to: .success))
        }
    }
    
    private var failureCell: some View {
        
        HStack {
            Spacer()
            Image("ic_res_fail")
                .resizable()
                .frame(width: 10, height: 10)
                .padding(.bottom, -2)
            Text(localStr("participants.search.filter.failure"))
                .foregroundColor(.codGray)
                .font(.main(size: 14))
                .padding([.top, .bottom], 8)
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(
                    participantsStore.state.filter == .failure ?
                        .monaLisa : .galleryDark
                )
        )
        .onTapGesture {
            participantsStore.dispatch(action: .changeType(to: .failure))
        }
    }
}

struct FilterView_Previews: PreviewProvider {

    static var previews: some View {
        FilterView()
            .environmentObject(ParticipantsStore(eventId: ""))
    }
}
