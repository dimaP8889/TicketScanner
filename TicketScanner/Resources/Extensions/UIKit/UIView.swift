//
//  UIView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 26.08.2021.
//

import UIKit

extension UIView {
    func crop(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
