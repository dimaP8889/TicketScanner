//
//  CheckedInUIKitView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.08.2021.
//

import UIKit
import SwiftUI

final class CheckedInUIKitView : NibableView {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    @IBOutlet private var dateView: UIView!
    
    var viewModel : CheckedInUIKitViewModel? {
        didSet { updateView() }
    }
    
    override func setView() {
        setLabelsParams()
    }
}

//MARK : View Building
private extension CheckedInUIKitView {
    
    func updateView() {
        setLabels()
        setDateView()
    }
    
    func setLabelsParams() {
        
        titleLabel.font = .main(ofSize: 17)
        titleLabel.textColor = UIColor(Color.radicalRed)
        titleLabel.text = localStr("scan.error.checked_in")
        
        timeLabel.font = .main(ofSize: 14)
        timeLabel.textColor = UIColor(Color.doveGray)
        
        dateLabel.font = .main(ofSize: 14)
        dateLabel.textColor = UIColor(Color.doveGray)
    }
    
    func setLabels() {
        guard let viewModel = viewModel else { return }
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        
    }
    
    func setDateView() {
        dateView.isHidden = viewModel?.date == nil || viewModel?.time == nil
    }
}
