//
//  ScanView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 07.06.2021.
//

import SwiftUI

struct ScanView: View {
    
    @EnvironmentObject var scanStore : ScanStore
    
    var body: some View {
        
        ZStack {
            VStack {
                ScanCameraView()
                    .padding([.leading, .trailing], 12)
                    .padding([.top, .bottom], 6)
                if !scanStore.state.isManual {
                    ShowManualView(tapAction: {
                        withAnimation {
                            scanStore.dispatch(action: .showManual)
                        }
                    })
                    .padding(.top, 6)
                    .padding(.bottom, 12)
                }
            }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
