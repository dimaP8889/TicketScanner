//
//  TabBarModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 08.06.2021.
//

import Combine

final class TabBarModel : ObservableObject {
    
    var selection : Int = 0 {
        didSet {
            switch selection {
            case 0:
                buttonSubtitle = localStr("events.item.scan")
            case 1:
                buttonSubtitle = localStr("events.item.participants")
            case 2:
                buttonSubtitle = localStr("events.item.contacts")
            case 3:
                buttonSubtitle = localStr("events.item.profile")
            default:
                buttonSubtitle = localStr("events.item.scan")
            }
        }
    }
    
    @Published var buttonSubtitle : String = localStr("events.item.scan")
}
