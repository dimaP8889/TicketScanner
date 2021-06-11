//
//  ScanCameraView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 08.06.2021.
//

import SwiftUI
import CodeScanner

struct ScanCameraView: View {
    
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
    }
}

private extension ScanCameraView {
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       
        switch result {
        case let .success(code):
            print(code)
        case .failure(let error):
            print(error)
        }
    }
}

struct ScanCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ScanCameraView()
    }
}
