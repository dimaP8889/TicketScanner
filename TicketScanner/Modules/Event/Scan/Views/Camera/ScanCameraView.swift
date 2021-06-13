//
//  ScanCameraView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 08.06.2021.
//

import SwiftUI
import CodeScanner

struct ScanCameraView: View {
    
    @EnvironmentObject private var alertObject : AlertObject
    
    var body: some View {
        ZStack {
            CodeScannerView(
                codeTypes: [.qr],
                scanMode: .oncePerCode,
                scanInterval: 2,
                completion: handleScan(result:)
            )
            .cornerRadius(20)
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
        .showPopup(alertObject: alertObject) {
            withAnimation {
                alertObject.alertModel = nil
            }
        }
    }
}

private extension ScanCameraView {
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       
        switch result {
        case let .success(code):
            showAlert(with: .test)
        case .failure(let error):
            showAlert(with: .test)
        }
    }
    
    //ahhhhh dont like this one
    func showAlert(with model: AlertModel) {
        
        if alertObject.alertModel != nil {
            withAnimation {
                alertObject.alertModel = nil
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation {
                alertObject.alertModel = model
            }
        }
    }
}

struct ScanCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ScanCameraView()
    }
}
