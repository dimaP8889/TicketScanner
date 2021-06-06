//
//  EventsView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 03.06.2021.
//

import SwiftUI

struct EventsView: View {
    
    var body: some View {
        NavigationView {
            Text("kiki")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text(localStr("events.toolbar.leading"))
                            .font(.main(size: 24))
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Help") {
                            print("Help tapped!")
                        }
                    }
                }
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
