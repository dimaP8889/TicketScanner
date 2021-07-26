//
//  EventsView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 03.06.2021.
//

import SwiftUI

struct EventsListView: View {
    
    @EnvironmentObject var appDataStore: AppDataStore
    @EnvironmentObject var eventListStore: EventListStore
    
    var models : [EventModel] {
        eventListStore.events
    }
    
    init() {
        UINavigationBar.setBar(color: .clear)
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    Spacer()
                        .frame(height: 10)
                    ForEach(Array(zip(models.indices, models)), id: \.0) { index, data in
                        NavigationLink(
                            destination: EventTabBarView(
                                eventName: data.festivalName,
                                eventId: eventListStore.eventId(by: index)
                            ),
                            label: {
                                EventDataView(model: data)
                                    .padding([.leading, .trailing], 12)
                                    .padding([.top, .bottom], 6)
                            }
                        )
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(localStr("events.toolbar.leading"))
                        .font(.main(size: 24))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        LogoutButton {
                            appDataStore.dispatch(action: .removeToken)
                        }
                        Spacer(minLength: 0)
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .accentColor(.codGray)
        }
        .onAppear {
            eventListStore.dispatch(action: .load)
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsListView()
    }
}
