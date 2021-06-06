//
//  EventsView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 03.06.2021.
//

import SwiftUI

struct EventsView: View {
    
    var models : [EventModel]
    
    init() {
        models = []
        models = createModel()
        models.sort { $0.startDate < $1.startDate }
        UINavigationBar.setBar(color: .white)
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 10)
                    ForEach(models) { data in
                        EventDataView(model: data)
                            .padding([.leading, .trailing], 12)
                            .padding([.top, .bottom], 6)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(localStr("events.toolbar.leading"))
                        .font(.main(size: 24))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        LogoutButton {
                            print("Logout")
                        }
                        Spacer(minLength: 0)
                    }
                }
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
        }
    }
}

private extension EventsView {
    
    func createModel() -> [EventModel] {
        
        var model = [EventModel]()
        let first = EventModel(startDate: Date(), endDate: Date(), festivalName: "Uncertain Festival 2021")
        model.append(first)

        for _ in 0...3 {
            var dayComponent = DateComponents()
            dayComponent.day = Int.random(in: 0...1000)
            let theCalendar = Calendar.current
            let nextDate = theCalendar.date(byAdding: dayComponent, to: Date())

            let ev = EventModel(startDate: nextDate!, endDate: nextDate!, festivalName: "Uncertain Festival 2021")
            model.append(ev)
        }
        
        for _ in 0...3 {
            var dayComponent = DateComponents()
            dayComponent.day = Int.random(in: 0...1234)
            let theCalendar = Calendar.current
            let start = theCalendar.date(byAdding: dayComponent, to: Date())
            
            let ev = EventModel(startDate: start!, endDate: Date(), festivalName: "Uncertain Festival 2021")
            model.append(ev)
        }
        return model
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
