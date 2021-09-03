//
//  ParticipantsTicketCell.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.08.2021.
//

import UIKit
import SwiftUI

final class ParticipantsTicketCell: UITableViewCell {
    
    @IBOutlet private var mainStackView: UIStackView!
    @IBOutlet private var mainView: UIView!
    
    // Short Ticket
    @IBOutlet private var shortTicketView: UIView!
    
    @IBOutlet private var resultTicker: UIImageView!
    @IBOutlet private var participantNameLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!

    // Status
    @IBOutlet private var statusStackView: UIStackView!
    @IBOutlet private var invalidQrView: InvalidQrUIKitView!
    @IBOutlet private var refundedView: RefundedUIKitView!
    @IBOutlet private var alreadyCheckedView: CheckedInUIKitView!
    @IBOutlet private var wrongEventView: WrongEventUIKitView!
    
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
    
    // Constraints
    @IBOutlet private var ticketTypeLabelWidth: NSLayoutConstraint!
    @IBOutlet private var phoneLabelWidth: NSLayoutConstraint!
    @IBOutlet private var emailLabelWidth: NSLayoutConstraint!
    
    @IBOutlet private var mainStackViewBottomConstraint: NSLayoutConstraint!
    
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
        setTicketType()
        setTicker()
        setLabels()
        setStatusViews()
        setCellColor()
        setViewAppearances()
    }
    
    @objc func didSelectCell() {
        
        guard let viewModel = viewModel else { return }
        
        viewModel.selectAction(viewModel.model.ticketId)
    }
}

// MARK: - Cell building
private extension ParticipantsTicketCell {
    
    func setupCell() {
        setMainView()
        setMainStackView()
        setLabelsParams()
        setSeparator()
        setStatusViews()
    }
    
    func setMainView() {
        
        mainView.crop(radius: 18)
        mainView.isUserInteractionEnabled = true
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectCell)))
    }
    
    func setTicketType() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        fullTicketView.isHidden = !viewModel.isOpened
    }
    
    func setTicker() {
        
        guard let viewModel = viewModel else { return }
        
        switch viewModel.model.status {
        case .success:
            resultTicker.image = UIImage(named: "ic_success_tick")
        default:
            resultTicker.image = UIImage(named: "ic_red_cross")
        }
    }
    
    func setLabelsParams() {
        
        participantNameLabel.font = .main(ofSize: 17)
        
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
        emailValueLabel.textColor = UIColor(Color.codGray)
    }
    
    func setLabels() {
        
        guard let viewModel = viewModel else { return }
        
        switch viewModel.model.status {
        case .invalidQR:
            participantNameLabel.text = localStr("alert.fail")
            participantNameLabel.textColor = UIColor(Color.newGray)
        case .success:
            participantNameLabel.text = viewModel.model.main.name
            participantNameLabel.textColor = UIColor(Color.codGray)
        default:
            participantNameLabel.text = viewModel.model.main.name
            participantNameLabel.textColor = UIColor(Color.newGray)
        }
        
        timeLabel.text = viewModel.model.main.time
        ticketNumberLabel.text = "# " + viewModel.model.main.ticketNumber
        ticketNumberLabel.isHidden = !viewModel.isOpened
        
        ticketTypeTitleLabel.text = localStr("scan.ticket.type")
        ticketTypeValueLabel.text = viewModel.model.secondary.type
        
        phoneNumberTitleLabel.text = localStr("scan.ticket.phone")
        phoneNumberValueLabel.text = viewModel.model.secondary.number
        
        emailTitleLabel.text = localStr("scan.ticket.email")
        emailValueLabel.text = viewModel.model.secondary.email
        
        setStackViewConstraints()
    }
    
    func setStackViewConstraints() {
        
        guard let viewModel = viewModel else { return }
        
        let typeWidth = localStr("scan.ticket.type").width(constraintedHeight: 20, font: .main(ofSize: 14))
        let phoneWidth = localStr("scan.ticket.phone").width(constraintedHeight: 20, font: .main(ofSize: 14))
        let emailWidth = localStr("scan.ticket.email").width(constraintedHeight: 20, font: .main(ofSize: 14))
        
        let max = max(typeWidth, phoneWidth, emailWidth)
        
        ticketTypeLabelWidth.constant = max
        phoneLabelWidth.constant = max
        emailLabelWidth.constant = max
        
        switch viewModel.model.status {
        case .invalidQR where viewModel.isOpened == true:
            mainStackViewBottomConstraint.constant = 32
        default:
            mainStackViewBottomConstraint.constant = 19
        }
    }
    
    func setStatusViews() {
        
        guard let viewModel = viewModel else { return }
        
        mainStackView.setCustomSpacing(32, after: statusStackView)
        invalidQrView.isHidden = true
        refundedView.isHidden = true
        alreadyCheckedView.isHidden = true
        wrongEventView.isHidden = true
        
        guard viewModel.isOpened else {
            statusStackView.isHidden = true
            return
        }
        
        statusStackView.isHidden = false
        
        switch viewModel.model.status {
        case let .checkedIn(time, date):
            let vm = CheckedInUIKitViewModel(time: time, date: date)
            alreadyCheckedView.viewModel = vm
            alreadyCheckedView.isHidden = false
        case .invalidQR:
            invalidQrView.isHidden = false
        case let .refunded(time):
            let vm = RefundedUIKitViewModel(date: time)
            refundedView.viewModel = vm
            refundedView.isHidden = false
        case .success:
            mainStackView.setCustomSpacing(0, after: statusStackView)
            return
        case let .wrongEvent(name, time):
            let vm = WrongEventUIKitViewModel(date: time, festivalName: name)
            wrongEventView.viewModel = vm
            wrongEventView.isHidden = false
        }
    }
    
    func setViewAppearances() {
        
        guard let viewModel = viewModel else { return }
        
        switch viewModel.model.status {
        case .invalidQR:
            ticketNumberLabel.isHidden = true
            fullTicketView.isHidden = true
        default:
            return
        }
    }
    
    func setMainStackView() {
        
        mainStackView.setCustomSpacing(24, after: ticketNumberLabel)
        mainStackView.setCustomSpacing(20, after: statusStackView)
    }
    
    func setCellColor() {
        
        guard let viewModel = viewModel else { return }
        
        mainView.backgroundColor = viewModel.isOpened ? UIColor(Color.galleryDark) : UIColor(Color.gallery)
    }
    
    func setSeparator() {
        separator.backgroundColor = UIColor.black.withAlphaComponent(0.05)
    }
}
