//
//  EventTabBarView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 07.06.2021.
//

import SwiftUI

struct EventTabBarView: View {
    
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    private var eventName : String
    private var eventId : String
    
    @ObservedObject private var data : TabBarModel
    
    private let scanStore = ScanStore(state: ScanModel())
    private let participantsStore = ParticipantsStore()
    
    init(eventName: String, eventId : String) {
        
        self.eventName = eventName
        self.eventId = eventId
        self.data = TabBarModel()
        
        UITabBar.setBar(color: .white)
    }
    
    
    var body: some View {
        
        TabView(selection: $data.selection) {
            ScanView()
                .environmentObject(scanStore)
                .tabItem {
                    Image("ic_scan")
                        .renderingMode(.template)
                    Text(localStr("events.item.scan"))
                        .font(.main(size: 11))
                }
                .tag(0)
            
            ParticipantsView()
                .environmentObject(participantsStore)
                .tabItem {
                    Image("ic_participants")
                        .renderingMode(.template)
                    Text(localStr("events.item.participants"))
                        .font(.main(size: 11))
                }
                .tag(1)
            
            ContactsView()
                .tabItem {
                    Image("ic_contacts")
                        .renderingMode(.template)
                    Text(localStr("events.item.contacts"))
                        .font(.main(size: 11))
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image("ic_profile")
                        .renderingMode(.template)
                    Text(localStr("events.item.profile"))
                        .font(.main(size: 11))
                }
                .tag(3)
            
        }
        .accentColor(.codGray)
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: EventsBackButton(
                backAction: {
                    presentationMode.wrappedValue.dismiss()
                },
                title: eventName,
                subtitle: $data.buttonSubtitle
            )
        )
    }
}

// MARK: - Private
private extension EventTabBarView {
    
    func title(for selection : Int) -> String {
        
        switch selection {
        case 0:
            return localStr("events.item.scan")
        case 1:
            return localStr("events.item.participants")
        case 2:
            return localStr("events.item.contacts")
        case 3:
            return localStr("events.item.profile")
        default:
            return localStr("events.item.scan")
        }
    }
}

struct EventTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        EventTabBarView(eventName: "first", eventId: "0")
    }
}
