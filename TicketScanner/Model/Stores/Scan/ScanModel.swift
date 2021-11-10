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
    
    case setEvent(id: String)
    case showManual
    case hideManual
    case showAlert(AlertModel)
    case hideAlert
    case showTicket
    case scan(validation: String)
    case setScanResult(Response<ScanSuccessResultApiModel, ScanFailResultApiModel>, String)
}
