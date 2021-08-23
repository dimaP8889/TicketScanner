//
//  ScanStore.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 13.06.2021.
//

import Foundation
import Combine
import SwiftUI

final class ScanStore : ObservableObject {
    
    @Published private(set) var state : ScanModel
    private var cancellables = Set<AnyCancellable>()
    
    private var reducer: ScanReducer
    
    init(eventId : String) {
        self.state = ScanModel(eventId: eventId)
        reducer = ScanReducer()
    }
    
    func dispatch(action: ScanAction) {
        guard let effect = reducer.reduce(state: &state, action: action) else {
            return
        }
        
        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dispatch(action:))
            .store(in: &cancellables)
    }
}

// MARK: - Public Ticket
extension ScanStore {
    
    var isTicketPresented : Bool {
        get { state.isTicketPresented }
        set { state.isTicketPresented = newValue }
    }
    
    var ticket : FullTicketModel {
        get { state.ticketModel ?? .random }
    }
}

// MARK: - Public Alert
extension ScanStore {
    
    var isAlertHidden : Bool {
        state.alertModel == nil
    }
    
    var alertModel : AlertModel? {
        state.alertModel
    }
}
