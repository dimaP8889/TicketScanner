//
//  EventModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.06.2021.
//

import SwiftUI
import Foundation

struct EventModel : Identifiable {
    
    let id : String
    
    let dates : String
    let festivalName : String
    let timeToStart : String
    let isActive : Bool
    
    let startDate : Date
    
    init(id : String, startDate: Date, endDate: Date?, festivalName : String) {
        
        self.id = id
        
        let dateFormatter = DateFormatter.eventFormatter
        self.startDate = startDate
        
        if let endDate = endDate {
            if startDate.isSameDay(with: endDate) {
                dates = dateFormatter.string(from: startDate)
            } else {
                let startDateString = dateFormatter.string(from: startDate)
                let endDateString = dateFormatter.string(from: endDate)
                
                dates = "\(startDateString) — \(endDateString)"
            }
        } else {
            dates = dateFormatter.string(from: startDate)
        }
        
        self.festivalName = festivalName
        
        let startTime = Date().time(to: startDate)
        let isFinished = endDate == nil ? false : endDate! < Date()
        
        if isFinished {
            self.timeToStart = localStr("events.future.ended")
            self.isActive = false
        } else {
            self.timeToStart = startTime
            self.isActive = true
        }
    }
}
