//
//  ScanModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 13.06.2021.
//

import Combine
import Foundation

struct ScanModel : Equatable {
    
    var isManual : Bool = false
    var alertModel : AlertModel? = nil
    var ticketModel : FullTicketModel? = nil
    var eventId : String = ""
    
    var isTicketPresented : Bool = false
    
    var sound : Sound {
        
        guard !isTicketPresented else {
            return .none
        }
        
        switch alertModel?.alertType {
        case .checkedIn, .invalidQR, .refunded, .wrongEvent:
            return .some("error")
        case .success:
            return .some("success")
        case .none:
            return .none
        }
    }
}

extension ScanModel {
    
    enum Sound {
        case some(String)
        case none
    }
}

enum ScanAction {
    
    case showManual
    case hideManual
    case showAlert(AlertModel)
    case hideAlert
    case showTicket
    case scan(validation: String)
    case setScanResult(Response<ScanSuccessResultApiModel, ScanFailResultApiModel>, String)
}

struct ScanReducer {
    
    var expiredTokenAction : Action?
    
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
                .map { ScanAction.setScanResult($0, validation) }
                .eraseToAnyPublisher()
        case let .setScanResult(response, validation):
            return parseScanResult(response: response, validation: validation, state: &state)
        }
        return nil
    }
}

private extension ScanReducer {
    
    func parseScanResult(
        response: Response<ScanSuccessResultApiModel, ScanFailResultApiModel>,
        validation: String,
        state: inout ScanModel
    ) -> AnyPublisher<ScanAction, Never>? {
        
        switch response {
        case .success:
            let alert = AlertModel(time: Date.currentTime, alertType: .success)
            state.ticketModel = nil
            return reduce(state: &state, action: .showAlert(alert))
        case let .backend(errorObject):
            let alert = errorObject.adaptToAlert(number: validation)
            state.ticketModel = alert.alertType.ticket
            return reduce(state: &state, action: .showAlert(alert))
        case let .system(error):
            print(error)
            return nil
        case .expiredToken:
            expiredTokenAction?()
            return nil
        }
    }
}
