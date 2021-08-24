//
//  NibableView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.08.2021.
//

import UIKit

class NibableView : UIView, NibableProtocol {
    
    @IBOutlet internal var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    ///override this method in child classes
    func setView() {}
}

// MARK: - Private
private extension NibableView {
    
    func commonInit() {
        
        registerView()
        setView()
    }
}
