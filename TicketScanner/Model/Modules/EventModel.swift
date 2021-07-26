//
//  EventModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.06.2021.
//

import Foundation

struct EventModel : Identifiable {
    
    let id : String
    
    let dates : String
    let festivalName : String
    let timeToStart : String
    let isActive : Bool
    
    let startDate : Date
    
    init(id : String, startDate: Date, endDate: Date, festivalName : String) {
        
        self.id = id
        
        let dateFormatter = DateFormatter.eventFormatter
        self.startDate = startDate
        
        if startDate.isSameDay(with: endDate) {
            dates = dateFormatter.string(from: startDate)
        } else {
            let startDateString = dateFormatter.string(from: startDate)
            let endDateString = dateFormatter.string(from: endDate)
            
            dates = "\(startDateString) — \(endDateString)"
        }
        
        self.festivalName = festivalName
        
        self.timeToStart = Date().time(to: startDate)
        
        self.isActive = self.timeToStart == localStr("events.future.started")
    }
}
