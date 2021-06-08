//
//  ScanView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 07.06.2021.
//

import SwiftUI

struct ScanView: View {
    
    var body: some View {
        
        VStack {
            ScanCameraView()
                .padding([.leading, .trailing], 12)
                .padding([.top, .bottom], 6)
            ShowNumberView(tapAction: {})
                .padding(.top, 6)
                .padding(.bottom, 12)
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
