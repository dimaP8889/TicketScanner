//
//  ScanModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 13.06.2021.
//

import Combine

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
    case scan(validation: String, eventId: String)
    case setScanResult(Response<ScanResultApiModel, ErrorResponse>)
}

struct ScanReducer {
    
    func reduce(state: inout ScanModel, action: ScanAction) -> AnyPublisher<ScanAction, Never>? {
        
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
        case let .scan(validation, eventId):
            return Networking.main?.scan(validation: validation, eventId: eventId)
                .map { ScanAction.setScanResult($0) }
                .eraseToAnyPublisher()
        case let .setScanResult(response):
            return parseScanResult(response: response)
        }
        return nil
    }
}

private extension ScanReducer {
    
    #warning("Change Parser")
    func parseScanResult(response: Response<ScanResultApiModel, ErrorResponse>) -> AnyPublisher<ScanAction, Never>? {
        
        switch response {
        case let .success(result):
            return nil
        default:
            return nil
        }
    }
}
