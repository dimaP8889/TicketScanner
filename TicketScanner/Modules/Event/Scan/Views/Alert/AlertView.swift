//
//  AlertView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct AlertView: View {
    
    private let model : AlertModel
    private let swipeAction : Action
    private let tapAction : Action
    private let tapWrongQrAction : Action
    
    @State private var yOffset : CGFloat = 0
    
    private let timer : Timer
    
    init(
        model: AlertModel,
        swipeAction: @escaping Action,
        tapAction: @escaping Action,
        tapWrongQrAction: @escaping Action
    ) {
        self.model = model
        self.swipeAction = swipeAction
        self.tapAction = tapAction
        self.tapWrongQrAction = tapWrongQrAction
        timer = Timer(timeInterval: Constants.alertApperTime, repeats: false) { _ in
            swipeAction()
        }
        RunLoop.main.add(timer, forMode: .common)
    }
    
    var body: some View {
        
        VStack {
            ZStack {
                if let vm = model.alertType.subviewModel {
                    AlertSubview(model: vm)
                        .offset(CGSize(width: 0,height: 37))
                }
                AlertContentView(model: model)
            }
            .frame(maxHeight: 70)
            Spacer()
        }
        .onDisappear {
            swipeAction()
            timer.invalidate()
        }
        .onTapGesture {
            model.isWrongQr ? tapWrongQrAction() : tapAction()
            timer.invalidate()
        }
        .gesture(
            DragGesture(
                minimumDistance: 0.3,
                coordinateSpace: .local
            )
            .onEnded{ value in
                if value.translation.height < 0 {
                    swipeAction()
                    timer.invalidate()
                }
            }
        )
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(model: .test, swipeAction: {}, tapAction: {}, tapWrongQrAction: {})
    }
}
