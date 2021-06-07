//
//  UITabBar.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 07.06.2021.
//

import UIKit

extension UITabBar {
    
    static func setBar(color: UIColor) {
        
        let backgroundColor = color
        
        let coloredAppearance = UITabBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        
        UITabBar.appearance().standardAppearance = coloredAppearance
    }
}
