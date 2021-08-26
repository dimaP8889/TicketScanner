//
//  ParticipantsTableView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 25.08.2021.
//

import UIKit
import SwiftUI

struct ParticipantsTableView: UIViewRepresentable {

    var participants : [ParticipantsInfoModel]
    var openedTicket : Int?
    var selectAction : TypeAction<Int>
    
    func makeCoordinator() -> Coordinator {
        Coordinator(participants: participants, openedTicket: openedTicket, selectAction: selectAction)
    }
    
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        let participantsTicketViewCellNib =
            UINib(nibName: "ParticipantsTicketCell", bundle: Bundle.main)
        tableView.register(participantsTicketViewCellNib,
                                          forCellReuseIdentifier: "ParticipantsTicketCell")
        
        let timeHeader = UINib(nibName: "TimeHeader", bundle: Bundle.main)
        tableView.register(timeHeader, forHeaderFooterViewReuseIdentifier: "TimeHeader")
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        context.coordinator.participants = participants
        context.coordinator.openedTicket = openedTicket
        uiView.reloadData()
    }
}

class Coordinator: NSObject {
    
    var participants : [ParticipantsInfoModel]
    var openedTicket : Int?
    var selectAction : TypeAction<Int>
    
    init(participants: [ParticipantsInfoModel], openedTicket : Int?, selectAction : @escaping TypeAction<Int>) {
        self.participants = participants
        self.openedTicket = openedTicket
        self.selectAction = selectAction
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
        cell.viewModel = .init(model: data, isOpened: data.ticketId == openedTicket, selectAction: selectAction)
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 26
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let data = participants[indexPath.section].tickets[indexPath.row]
        
        if data.ticketId == openedTicket {
            return 260
        } else {
            return 58
        }
    }
}


