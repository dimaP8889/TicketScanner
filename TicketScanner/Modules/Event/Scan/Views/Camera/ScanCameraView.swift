//
//  ScanCameraView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 08.06.2021.
//

import SwiftUI
import Combine
import CodeScanner

struct ScanCameraView: View {
    
    @EnvironmentObject private var scanStore : ScanStore
    
    @State private var radius : CGFloat = 0
    @State private var startTime = Date()
    
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    private var startRadius : CGFloat = 100

    var body: some View {
        ZStack {
            if scanStore.state.isManual {
                ManualEnterView()
                    .onAppear {
                        // Calling this method to set blur
                        // when show manual view
                        radius = startRadius
                    }
            } else {
                CodeScannerView(
                    codeTypes: [.qr],
                    scanMode: .continuous,
                    scanInterval: Constants.scanRefreshTime,
                    completion: handleScan(result:)
                )
                .blur(radius: radius, opaque: true)
                .onAppear {
                    startTimer()
                }
                .onReceive(timer) { _ in
                    radius = radius - 1
                    if radius < 0 {
                        stopTimer()
                    }
                }
                .cornerRadius(20)
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    FlashView()
                        .frame(width: 62, height: 62)
                        .padding([.trailing, .bottom], 12)
                }
            }
        }
        .onTapGesture {
            #warning("Delete later")
            showAlert(with: AlertModel.test)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.newGray)
        )
        .showPopup(
            alertModel: scanStore.alertModel,
            swipeAction: {
                withAnimation {
                    scanStore.dispatch(action: .hideAlert)
                }
            }, tapAction: {
                scanStore.dispatch(action: .showTicket)
            }, tapWrongQrAction: {
                withAnimation {
                    scanStore.dispatch(action: .showManual)
                }
            }
        )
    }
}

private extension ScanCameraView {
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        
        switch result {
        case let .success(code):
            scanStore.dispatch(action: .scan(validation: code))
        case .failure:
            return
        }
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
    
    //ahhhhh dont like this one
    #warning("Change alert appearance")
    func showAlert(with model: AlertModel) {
        
        if scanStore.state.alertModel != nil {
            withAnimation {
                scanStore.dispatch(action: .hideAlert)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                scanStore.dispatch(action: .showAlert(model))
            }
        }
    }
}

struct ScanCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ScanCameraView()
    }
}
