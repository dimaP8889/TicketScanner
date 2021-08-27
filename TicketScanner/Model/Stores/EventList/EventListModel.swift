//
//  EventListData.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 26.07.2021.
//

import Combine

struct EventListModel {
    
    var eventList : [EventModel]
}

enum EventListAction {
    
    case load
    case set(Response<EventListApiModel, ErrorResponse>)
}

struct EventListReducer {
    
    var expiredTokenAction : Action?
    
    func reduce(oldState : inout EventListModel, action : EventListAction) -> AnyPublisher<EventListAction, Never>? {
        
        switch action {
        case .load:
            return Networking.main?.loadEvents()
                .map { EventListAction.set($0) }
                .eraseToAnyPublisher()
        case let .set(response):
            switch response {
            case let .success(model):
                var events = model.adaptToEventModelList
                events.sort { $0.startDate < $1.startDate }
                oldState.eventList = events
            case .expiredToken:
                expiredTokenAction?()
            default:
                break
            }
            return nil
        }
    }
}


