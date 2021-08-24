//
//  NibableProtocol.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 24.08.2021.
//

import UIKit

protocol NibableProtocol : AnyObject {
    
    var contentView: UIView!  { get }
    
    func registerView()
}

extension NibableProtocol where Self : UIView {
    
    func registerView() {
        
        Bundle.main.loadNibNamed("\(type(of: self))", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = contentView.topAnchor.constraint(equalTo: topAnchor)
        let leading = contentView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let bottom = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        addConstraints([top, bottom, leading, trailing])
    }
}
