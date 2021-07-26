//
//  EventListStore.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 26.07.2021.
//

import Foundation
import Combine

final class EventListStore : ObservableObject {
    
    @Published var model : EventListModel
    private let reducer : EventListReducer
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        model = EventListModel(eventList: [])
        reducer = EventListReducer()
    }
    
    func eventId(by index: Int) -> String {
        model.eventList[index].id
    }
    
    var events : [EventModel] {
        model.eventList
    }
    
    func dispatch(action : EventListAction) {
        
        guard let effect = reducer.reduce(oldState: &model, action: action) else { return }
        
        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dispatch(action:))
            .store(in: &cancellables)
    }
}
