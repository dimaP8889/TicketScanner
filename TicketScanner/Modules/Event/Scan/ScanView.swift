//
//  ScanView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 07.06.2021.
//

import SwiftUI
import AVFoundation

struct ScanView: View {
    
    @EnvironmentObject var scanStore : ScanStore
    @State private var audioPlayer: AVAudioPlayer!
    
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
            NavigationLink(
                destination: FullTicketView(model: scanStore.ticket),
                isActive: $scanStore.isTicketPresented
            ) { EmptyView() }
            .hidden()
        }
        .onReceive(scanStore.$state) { store in
            switch store.sound {
            case let .some(sound):
                playSounds(sound)
            case .none:
                return
            }
        }
    }
}

private extension ScanView {
    
    func playSounds(_ soundFileName : String) {
            guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "wav") else {
                fatalError("Unable to find \(soundFileName) in bundle")
            }

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            } catch {
                print(error.localizedDescription)
            }
            audioPlayer.play()
        }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
