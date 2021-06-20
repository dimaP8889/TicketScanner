//
//  ScanModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 13.06.2021.
//

import Foundation

struct ScanModel {
    
    var isManual : Bool = false
    var alertModel : AlertModel? = nil
    
    var isTicketPresented : Bool = false
}

enum ScanAction {
    
    case showManual
    case hideManual
    case showAlert(AlertModel)
    case hideAlert
    case showTicket
}

struct ScanReducer {
    
    func reduce(state: inout ScanModel, action: ScanAction) {
        
        switch action {
        case .hideAlert:
            state.alertModel = nil
        case let .showAlert(model):
            state.alertModel = model
        case .showManual:
            state.isManual = true
            state.alertModel = nil
        case .hideManual:
            state.isManual = false
            state.alertModel = nil
        case .showTicket:
            let hasTicket = state.alertModel?.alertType.ticket != nil
            state.isTicketPresented = hasTicket
        }
    }
}
