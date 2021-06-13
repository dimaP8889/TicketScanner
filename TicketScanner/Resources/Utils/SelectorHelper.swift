//
//  SelectorHelper.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 13.06.2021.
//

import Foundation

final class SelectorHelper {

    private var action : Action
    
    init(action: @escaping Action) {
        self.action = action
    }
    
    @objc func selectorAction() {
        action()
    }
}
