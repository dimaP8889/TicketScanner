//
//  AppDataStore.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 15.06.2021.
//

import Foundation
import SwiftUI

final class AppDataStore : ObservableObject {
    
    @Published private(set) var state : AppData
    
    private var reducer: AppDataReducer
    
    init(state : AppData) {
        self.state = state
        reducer = AppDataReducer()
    }

    func dispatch(action: AppDataAction) {
        let newState = reducer.reduce(oldState: state, action: action)
        state = newState
    }
}
