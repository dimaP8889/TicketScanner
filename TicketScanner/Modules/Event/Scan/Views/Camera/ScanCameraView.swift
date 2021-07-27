//
//  ScanCameraView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 08.06.2021.
//

import SwiftUI
import CodeScanner

struct ScanCameraView: View {
    
    @EnvironmentObject private var scanStore : ScanStore
    
    var body: some View {
        ZStack {
            if scanStore.state.isManual {
                ManualEnterView { _ in
                    showAlert(with: .test)
                }
            } else {
                CodeScannerView(
                    codeTypes: [.qr],
                    scanMode: .oncePerCode,
                    scanInterval: 2,
                    completion: handleScan(result:)
                )
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
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.newGray)
        )
        .showPopup(
            alertModel: scanStore.state.alertModel,
            swipeAction: {
                withAnimation {
                    scanStore.dispatch(action: .hideAlert)
                }
            }, tapAction: {
                scanStore.dispatch(action: .showTicket)
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
            showAlert(with: .test)
        }
    }
    
    //ahhhhh dont like this one
    func showAlert(with model: AlertModel) {
        
        if scanStore.state.alertModel != nil {
            withAnimation {
                scanStore.dispatch(action: .hideAlert)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
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
