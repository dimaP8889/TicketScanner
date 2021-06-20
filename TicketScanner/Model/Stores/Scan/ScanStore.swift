//
//  ScanStore.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 13.06.2021.
//

import Foundation
import SwiftUI

final class ScanStore : ObservableObject {
    
    @Published private(set) var state : ScanModel
    
    private var reducer: ScanReducer
    
    init(state : ScanModel) {
        self.state = state
        reducer = ScanReducer()
    }
    
    var isTicketPresented : Bool {
        get { state.isTicketPresented }
        set { state.isTicketPresented = newValue }
    }
    
    func dispatch(action: ScanAction) {
        reducer.reduce(state: &state, action: action)
    }
}
