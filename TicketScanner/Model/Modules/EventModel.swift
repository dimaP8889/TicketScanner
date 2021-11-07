//
//  EventModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.06.2021.
//

import SwiftUI
import Foundation

struct EventModel : Identifiable, Equatable {
    
    let id : String
    
    let dates : String
    let festivalName : String
    let timeToStart : String
    
    let isOpened : Bool
    let isActive : Bool
    
    let startDate : Date
    
    init(id : String, startDate: Date, endDate: Date?, festivalName : String) {
        
        self.id = id
        
        let dateFormatter = DateFormatter.eventFormatter
        self.startDate = startDate
        
        dates = dateFormatter.string(from: startDate)
        
        self.festivalName = festivalName
        
        let startTime = Date().time(to: startDate)
        
        let isFinished = endDate == nil ? false : endDate! < Date()
        let isStarted = startDate <= Date()
        
        if isFinished {
            self.timeToStart = localStr("events.future.ended")
            self.isOpened = false
            self.isActive = false
        } else {
            self.timeToStart = startTime
            self.isOpened = true
            self.isActive = isStarted
        }
    }
}
