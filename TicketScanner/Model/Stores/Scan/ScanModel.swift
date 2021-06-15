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
    
    func reduce(oldState: ScanModel, action: ScanAction) -> ScanModel {
        
        switch action {
        case .hideAlert:
            let newState = ScanModel(isManual: oldState.isManual, alertModel: nil)
            return newState
        case let .showAlert(model):
            let newState = ScanModel(isManual: oldState.isManual, alertModel: model)
            return newState
        case .showManual:
            let newState = ScanModel(isManual: true, alertModel: nil)
            return newState
        case .hideManual:
            let newState = ScanModel(isManual: false, alertModel: nil)
            return newState
        case .showTicket:
            let hasTicket = oldState.alertModel?.alertType.ticket != nil
            let newState = ScanModel(isManual: oldState.isManual, alertModel: oldState.alertModel, isTicketPresented: hasTicket)
            return newState
        }
    }
}
