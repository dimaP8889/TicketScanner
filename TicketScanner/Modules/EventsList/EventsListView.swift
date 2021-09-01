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
    
    @State private var isNavLinkActive : Bool = false
    @State private var selectedEvent : EventModel?
    
    var models : [EventModel] {
        eventListStore.events
    }
    
    init() {
        UINavigationBar.setBar(color: .white)
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    Spacer()
                        .frame(height: 10)
                    ForEach(Array(zip(models.indices, models)), id: \.0) { index, data in
                        Button(
                            action: {
                                selectedEvent = data
                                isNavLinkActive = data.isActive
                            },
                            label: {
                                EventDataView(model: data)
                            }
                        )
                        .buttonStyle(PlainButtonStyle())
                        .padding([.leading, .trailing], 12)
                        .padding([.top, .bottom], 6)
                    }
                }
            }
            .background(
                NavigationLink(
                    destination: EventTabBarView(
                        event: selectedEvent
                    ),
                    isActive: $isNavLinkActive,
                    label: { EmptyView() }
                )
            )
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
