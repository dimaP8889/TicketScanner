//
//  View.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

extension View {
    
    func showPopup(
        alertModel: AlertModel?,
        swipeAction: @escaping Action,
        tapAction: @escaping Action,
        tapWrongQrAction: @escaping Action
    ) -> some View {
        ZStack {
            self
            if let model = alertModel {
                AlertView(
                    model: model,
                    swipeAction: swipeAction,
                    tapAction: tapAction,
                    tapWrongQrAction: tapWrongQrAction
                )
                    .transition(.move(edge: .top))
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 19))
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    /// Calls the completion handler whenever an animation on the given value completes.
    /// - Parameters:
    ///   - value: The value to observe for animations.
    ///   - completion: The completion callback to call once the animation completes.
    /// - Returns: A modified `View` instance with the observer attached.
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    }
}
