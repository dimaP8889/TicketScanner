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
                completion: self.handleScan
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
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                alertObject.alertModel = .test
            }
        }
        .showPopup(alertObject: alertObject)
    }
}

private extension ScanCameraView {
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       
        switch result {
        case let .success(code):
            alertObject.alertModel = .test
        case .failure(let error):
            alertObject.alertModel = .test
        }
    }
}

struct ScanCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ScanCameraView()
    }
}
