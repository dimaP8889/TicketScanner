//
//  EventTabBarView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 07.06.2021.
//

import SwiftUI

struct EventTabBarView: View {
    
    @ObservedObject private var data : TabBarModel
    
    @EnvironmentObject
    var appDataStore: AppStore
    
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    private var eventName : String {
        event?.festivalName ?? ""
    }
    private var event : EventModel?
    
    init(event: EventModel?) {
        
        self.event = event
        self.data = TabBarModel()
        
        UITabBar.setBar(color: .white)
    }
    
    var body: some View {
        
        TabView(selection: $data.selection) {
            ScanView()
                .environmentObject(
                    appDataStore.derived(
                        deriveState: \.scan,
                        embedAction: AppAction.scan
                    )
                )
                .tabItem {
                    Image("ic_scan")
                        .renderingMode(.template)
                    Text(localStr("events.item.scan"))
                        .font(.main(size: 11))
                }
                .tag(0)
            
            ParticipantsView()
                .environmentObject(
                    appDataStore.derived(
                        deriveState: \.participants,
                        embedAction: AppAction.participants
                    )
                )
                .tabItem {
                    Image("ic_participants")
                        .renderingMode(.template)
                    Text(localStr("events.item.participants"))
                        .font(.main(size: 11))
                }
                .tag(1)

            #warning("TODO")
//            ContactsView()
//                .tabItem {
//                    Image("ic_contacts")
//                        .renderingMode(.template)
//                    Text(localStr("events.item.contacts"))
//                        .font(.main(size: 11))
//                }
//                .tag(2)
            
            ProfileView()
                .environmentObject(
                    appDataStore.derived(
                        deriveState: \.app,
                        embedAction: AppAction.app
                    )
                )
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EventsBackButton(
                    backAction: {
                        presentationMode.wrappedValue.dismiss()
                    },
                    title: eventName,
                    subtitle: $data.buttonSubtitle
                )
            }
        }
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
        EventTabBarView(event: EventModel(id: "123", startDate: Date(), endDate: Date(), festivalName: "Lol"))
    }
}
