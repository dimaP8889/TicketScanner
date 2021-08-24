//
//  InvalidQrUIKitView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.08.2021.
//

import UIKit
import SwiftUI

final class InvalidQrUIKitView : NibableView {
    
    @IBOutlet private var titleLabel: UILabel!
    
    override func setView() {
        setLabel()
    }
}

//MARK : View Building
private extension InvalidQrUIKitView {
    
    func setLabel() {
        
        titleLabel.font = .main(ofSize: 17)
        titleLabel.textColor = UIColor(Color.radicalRed)
        titleLabel.text = localStr("scan.error.invalidQR")
    }
}
