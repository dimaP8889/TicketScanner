//
//  WrongEventUIKitView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.08.2021.
//

import UIKit
import SwiftUI

final class WrongEventUIKitView : NibableView {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var festivalNameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    @IBOutlet private var stackView: UIStackView!
    
    var viewModel : WrongEventUIKitViewModel? {
        didSet { updateView() }
    }
    
    override func setView() {
        setLabelsParams()
        setStackView()
    }
}

//MARK : View Building
private extension WrongEventUIKitView {
    
    func updateView() {
        setLabels()
    }
    
    func setLabelsParams() {
        
        titleLabel.font = .main(ofSize: 17)
        titleLabel.textColor = UIColor(Color.radicalRed)
        titleLabel.text = localStr("scan.error.wrong_event")
        
        descriptionLabel.font = .main(ofSize: 14)
        descriptionLabel.textColor = UIColor(Color.doveGray)
        descriptionLabel.text = localStr("scan.error.wrong_event.secondary")
        
        festivalNameLabel.font = .main(ofSize: 14)
        festivalNameLabel.textColor = UIColor(Color.codGray)
        
        dateLabel.font = .main(ofSize: 14)
        dateLabel.textColor = UIColor(Color.codGray)
    }
    
    func setStackView() {
        
        stackView.setCustomSpacing(8, after: titleLabel)
        stackView.setCustomSpacing(2, after: festivalNameLabel)
    }
    
    func setLabels() {
        guard let viewModel = viewModel else { return }
        festivalNameLabel.text = viewModel.festivalName
        dateLabel.text = viewModel.date
    }
}
