//
//  RefundedUIKitView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.08.2021.
//

import UIKit
import SwiftUI

final class RefundedUIKitView : NibableView {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    @IBOutlet private var dateView: UIView!
    
    var viewModel : RefundedUIKitViewModel? {
        didSet { updateView() }
    }
    
    override func setView() {
        setLabelsParams()
    }
}

//MARK : View Building
private extension RefundedUIKitView {
    
    func updateView() {
        setLabels()
        setDateView()
    }
    
    func setLabelsParams() {
        
        titleLabel.font = .main(ofSize: 17)
        titleLabel.textColor = UIColor(Color.radicalRed)
        titleLabel.text = localStr("scan.error.refunded")
        
        dateLabel.font = .main(ofSize: 14)
        dateLabel.textColor = UIColor(Color.doveGray)
    }
    
    func setLabels() {
        guard let viewModel = viewModel else { return }
        dateLabel.text = viewModel.date
    }
    
    func setDateView() {
        dateView.isHidden = viewModel?.date == nil
    }
}
