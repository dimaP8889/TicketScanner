//
//  AlertModel.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct AlertModel : Identifiable {
    
    let id = UUID()
    
    let time : String
    let alertType : AlertType
}

struct AlertSubviewModel {
    
    let title : String?
    let isTicket : Bool
}

extension AlertModel {
    
    static var test : AlertModel {
        
        let types : [AlertType] = [.checkedIn(time: "23:46", ticket: FullTicketModel.random), .invalidQR, .refunded(ticket: FullTicketModel.random), .success, .wrongEvent(ticket: FullTicketModel.random)]
        
        return AlertModel(time: "18:54:13", alertType: types.randomElement()!)
    }
}

extension AlertSubviewModel {
    
    static var test : AlertSubviewModel {
        
        let types : [AlertModel.AlertType] = [.checkedIn(time: "23:46", ticket: FullTicketModel.random), .invalidQR, .refunded(ticket: FullTicketModel.random), .success, .wrongEvent(ticket: FullTicketModel.random)]
        
        return types.randomElement()!.subviewModel!
    }
}

extension AlertModel {
    
    enum AlertType {
        case success
        case invalidQR
        case checkedIn(time: String, ticket: FullTicketModel)
        case refunded(ticket: FullTicketModel)
        case wrongEvent(ticket: FullTicketModel)
        
        var result : String {
            switch self {
            case .success:
                return localStr("alert.sucess")
            default:
                return localStr("alert.fail")
            }
        }
        
        var topTexColor : Color {
            switch self {
            case .success:
                return Color.apple
            default:
                return Color.radicalRed
            }
        }
        
        var alertColor : Color {
            switch self {
            case .success:
                return Color.screaminGreen
            default:
                return Color.monaLisa
            }
        }
        
        var resultIcon : String {
            switch self {
            case .success:
                return "ic_res_success"
            default:
                return "ic_res_fail"
            }
        }
        
        var mainText : String {
            switch self {
            case .checkedIn:
                return localStr("alert.title.checked")
            case .invalidQR:
                return localStr("alert.title.invalidQR")
            case .refunded:
                return localStr("alert.title.refunded")
            case .wrongEvent:
                return localStr("alert.title.wrong")
            case .success:
                return localStr("alert.title.success")
            }
        }
        
        var subviewModel : AlertSubviewModel? {
            switch self {
            case let .checkedIn(time, _):
                return AlertSubviewModel(title: localStr("alert.subtitle.visited") + time, isTicket: true)
            case .invalidQR:
                return AlertSubviewModel(title: localStr("alert.subtitle.enter_number"), isTicket: false)
            case .refunded:
                return AlertSubviewModel(title: nil, isTicket: true)
            case .wrongEvent:
                return AlertSubviewModel(title: nil, isTicket: true)
            case .success:
                return nil
            }
        }
        
        var ticket : FullTicketModel? {
            
            switch self {
            case let .checkedIn(_, ticket):
                return ticket
            case .invalidQR:
                return nil
            case let .refunded(ticket):
                return ticket
            case let .wrongEvent(ticket):
                return ticket
            case .success:
                return nil
            }
        }
    }
}
