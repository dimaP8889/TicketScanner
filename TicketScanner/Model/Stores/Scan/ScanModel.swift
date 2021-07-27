//
//  ScanModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 13.06.2021.
//

import Combine
import Foundation

struct ScanModel {
    
    var isManual : Bool = false
    var alertModel : AlertModel? = nil
    var eventId : String
    
    var isTicketPresented : Bool = false
}

enum ScanAction {
    
    case showManual
    case hideManual
    case showAlert(AlertModel)
    case hideAlert
    case showTicket
    case scan(validation: String)
    case setScanResult(Response<ScanSuccessResultApiModel, ScanFailResultApiModel>)
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
        case let .scan(validation):
            return Networking.main?.scan(validation: validation, eventId: state.eventId)
                .map { ScanAction.setScanResult($0) }
                .eraseToAnyPublisher()
        case let .setScanResult(response):
            return parseScanResult(response: response, state: &state)
        }
        return nil
    }
}

private extension ScanReducer {
    
    func parseScanResult(
        response: Response<ScanSuccessResultApiModel, ScanFailResultApiModel>,
        state: inout ScanModel
    ) -> AnyPublisher<ScanAction, Never>? {
        
        switch response {
        case .success:
            let alert = AlertModel(time: Date().currentTime, alertType: .success)
            return reduce(state: &state, action: .showAlert(alert))
        case let .backend(errorObject):
            let alert = errorObject.adaptToAlert
            return reduce(state: &state, action: .showAlert(alert))
        case let .system(error):
            print(error)
            return nil
        }
    }
}
