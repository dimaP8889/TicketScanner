//
//  KeyboardHeightHelper.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 27.05.2021.
//

import Foundation
import UIKit
import SwiftUI


class KeyboardHeightHelper: ObservableObject {
    
    @Published var isKeyboardShown : Bool = false
    @Published var keyboardHeight : CGFloat = 0
    private let notificationCenter = NotificationCenter.default
    
    init() {
        listenForKeyboardNotifications()
    }
    
    deinit {
        stopObserving()
    }
    
    private func listenForKeyboardNotifications() {
        notificationCenter.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main)
        { (notification) in
            
            guard let userInfo = notification.userInfo,
                  let rect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            withAnimation(.easeOut(duration: 1)) {
                self.keyboardHeight = rect.height
                self.isKeyboardShown = true
            }
        }
        
        notificationCenter.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main)
        { (notification) in
            withAnimation {
                self.keyboardHeight = 0
                self.isKeyboardShown = false
            }
        }
    }
    
    private func stopObserving() {
        notificationCenter.removeObserver(
            self, name: UIResponder.keyboardWillShowNotification, object: nil
        )
        notificationCenter.removeObserver(
            self, name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
}
