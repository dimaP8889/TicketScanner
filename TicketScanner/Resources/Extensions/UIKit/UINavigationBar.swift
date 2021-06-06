//
//  UINavigationBar.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 06.06.2021.
//

import UIKit

extension UINavigationBar {
    
    static func setBar(color: UIColor) {
        
        let backgroundColor = color
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
    }
}
