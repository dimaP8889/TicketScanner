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
    
    func dispatch(action: ScanAction) {
        let newState = reducer.reduce(oldState: state, action: action)
        state = newState
    }
}
