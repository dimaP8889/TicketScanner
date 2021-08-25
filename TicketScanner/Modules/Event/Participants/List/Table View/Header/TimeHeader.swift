//
//  TimeHeader.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 25.08.2021.
//

import UIKit
import SwiftUI

final class TimeHeader: UITableViewHeaderFooterView {
    
    @IBOutlet private var timeLabel: UILabel!
    
    var time : String? {
        didSet { timeLabel.text = time }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
    }
}

private extension TimeHeader {
    
    func setLabel() {
        timeLabel.font = .main(ofSize: 14)
        timeLabel.textColor = UIColor(Color.codGray)
    }
}

