//
//  ParticipantsTicketCell.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.08.2021.
//

import UIKit
import SwiftUI

final class ParticipantsTicketCell: UITableViewCell {
    
    @IBOutlet var mainStackView: UIStackView!
    
    // Short Ticket
    @IBOutlet private var shortTicketView: UIView!
    
    @IBOutlet private var participantNameLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!

    // Status
    @IBOutlet var invalidQrView: InvalidQrUIKitView!
    @IBOutlet var refundedView: RefundedUIKitView!
    @IBOutlet var alreadyCheckedView: CheckedInUIKitView!
    @IBOutlet var wrongEventView: WrongEventUIKitView!
    
    // Full Ticket
    @IBOutlet private var fullTicketView: UIView!
    
    @IBOutlet private var ticketNumberLabel: UILabel!
    @IBOutlet private var separator: UIView!
    
    @IBOutlet private var ticketTypeTitleLabel: UILabel!
    @IBOutlet private var ticketTypeValueLabel: UILabel!
    
    @IBOutlet private var phoneNumberTitleLabel: UILabel!
    @IBOutlet private var phoneNumberValueLabel: UILabel!
    
    @IBOutlet private var emailTitleLabel: UILabel!
    @IBOutlet private var emailValueLabel: UILabel!
    
    var viewModel: ParticipantsTicketViewModel? {
        didSet {
            updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
        updateCell()
    }
}

// MARK: - Private
private extension ParticipantsTicketCell {
    
    func updateCell() {
        #warning("todo")
    }
}

// MARK: - Cell building
private extension ParticipantsTicketCell {
    
    func setupCell() {
        #warning("todo")
    }
    
    func setTicketType() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        shortTicketView.isHidden = viewModel.isOpened
        fullTicketView.isHidden = !viewModel.isOpened
    }
    
    func setLabelsParams() {
        
        participantNameLabel.font = .main(ofSize: 17)
        participantNameLabel.textColor = UIColor(Color.codGray)
        
        timeLabel.font = .main(ofSize: 14)
        timeLabel.textColor = UIColor(Color.newGray)
        
        ticketNumberLabel.font = .main(ofSize: 17)
        ticketNumberLabel.textColor = UIColor(Color.codGray)
        
        
        ticketTypeTitleLabel.font = .main(ofSize: 14)
        ticketTypeTitleLabel.textColor = UIColor(Color.doveGray)
        
        ticketTypeValueLabel.font = .main(ofSize: 14)
        ticketTypeValueLabel.textColor = UIColor(Color.codGray)
        
        
        phoneNumberTitleLabel.font = .main(ofSize: 14)
        phoneNumberTitleLabel.textColor = UIColor(Color.doveGray)
        
        phoneNumberValueLabel.font = .main(ofSize: 14)
        phoneNumberValueLabel.textColor = UIColor(Color.codGray)
        
        
        emailTitleLabel.font = .main(ofSize: 14)
        emailTitleLabel.textColor = UIColor(Color.doveGray)
        
        emailValueLabel.font = .main(ofSize: 14)
        emailTitleLabel.textColor = UIColor(Color.codGray)
    }
    
    func setStatusViews() {
        
        invalidQrView.isHidden = true
        refundedView.isHidden = true
        alreadyCheckedView.isHidden = true
        wrongEventView.isHidden = true
        
        
    }
}
