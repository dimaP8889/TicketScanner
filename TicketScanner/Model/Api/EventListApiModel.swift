//
//  EventListModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 26.07.2021.
//

import Foundation

struct EventListApiModel : Codable {
    
    let events : [EventApiModel]
}

struct EventApiModel : Codable {
    
    enum CodingKeys : String, CodingKey {
        
        case titleUk = "title_uk"
        case titleEn = "title_en"
        case startDateTime = "start_date_time"
        case endDateTime = "end_date_time"
        case id
    }
    
    let titleUk : String
    let titleEn : String?
    let startDateTime : Int
    let endDateTime : Int?
    let id : String
}

extension EventListApiModel {
    
    var adaptToEventModelList : [EventModel] {
        
        events.map { apiModel in
            
            let startDate = Date(timeIntervalSince1970: TimeInterval(apiModel.startDateTime / 1000))
            let endDate =  apiModel.endDateTime == nil ? nil : Date(timeIntervalSince1970: TimeInterval(apiModel.endDateTime! / 1000))
            
            let title : String
            switch Defaults.shared.getCurrentLang() {
            case "en":
                title = apiModel.titleEn ?? apiModel.titleUk
            default:
                title = apiModel.titleUk
            }
            
            return EventModel(id: apiModel.id, startDate: startDate, endDate: endDate, festivalName: title)
        }
    }
}
