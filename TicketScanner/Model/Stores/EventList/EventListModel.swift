//
//  EventListData.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 26.07.2021.
//

import Combine

struct EventListModel : Equatable {
    
    var eventList : [EventModel] = []
}

enum EventListAction {
    
    case load
    case set(Response<EventListApiModel, ErrorResponse>)
}
