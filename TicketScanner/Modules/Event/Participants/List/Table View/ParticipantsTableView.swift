//
//  ParticipantsTableView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 25.08.2021.
//

import UIKit
import SwiftUI

struct ParticipantsTableView: UIViewControllerRepresentable {
    
    var participants : [ParticipantsInfoModel]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(participants: participants)
    }
    
    func makeUIViewController(context: Context) ->
    UITableViewController {
        UITableViewController(style: .grouped)
    }
    
    func updateUIViewController(_ viewController:
                                    UITableViewController,
                                context: Context) {
        viewController.tableView.dataSource = context.coordinator
        viewController.tableView.delegate = context.coordinator
        viewController.tableView.separatorStyle = .none
        viewController.tableView.backgroundColor = .white
        
        let participantsTicketViewCellNib =
            UINib(nibName: "ParticipantsTicketCell", bundle: Bundle.main)
        viewController.tableView.register(participantsTicketViewCellNib,
                                          forCellReuseIdentifier: "ParticipantsTicketCell")
        
        let timeHeader = UINib(nibName: "TimeHeader", bundle: Bundle.main)
        viewController.tableView.register(timeHeader, forHeaderFooterViewReuseIdentifier: "TimeHeader")
    }
}

class Coordinator: NSObject {
    var participants : [ParticipantsInfoModel]
    
    init(participants: [ParticipantsInfoModel]) {
        self.participants = participants
    }
}


extension Coordinator: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        participants.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        participants[section].tickets.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ParticipantsTicketCell",
            for: indexPath) as! ParticipantsTicketCell
        
        let data = participants[indexPath.section].tickets[indexPath.row]
        cell.viewModel = .init(model: data, isOpened: true)
        return cell
        
    }
}

extension Coordinator: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let time = participants[section].time
        
        let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "TimeHeader") as! TimeHeader
        view.time = time
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}


