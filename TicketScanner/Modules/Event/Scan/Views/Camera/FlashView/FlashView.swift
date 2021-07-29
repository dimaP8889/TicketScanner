//
//  FlashView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 08.06.2021.
//

import SwiftUI
import AVFoundation

struct FlashView: View {
    
    @State private var isFlashOn : Bool = false
    
    var body: some View {
        Group {
            Image("ic_flash")
        }
        .padding([.leading, .trailing], 25.5)
        .padding([.top, .bottom], 22.5)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(isFlashOn ? Color.gallery : Color.doveGray)
        )
        .onTapGesture {
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            isFlashOn.toggle()
            toggleTorch(on: isFlashOn)
        }
        .onAppear {
            isFlashOn = isDeviceFlashOn
        }
    }
}

// MARK: - Private
private extension FlashView {
    
    func toggleTorch(on: Bool) {
        
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    var isDeviceFlashOn : Bool {
        guard let device = AVCaptureDevice.default(for: .video) else { return false
        }
        
        if device.hasTorch {
            return device.torchMode == .on
        } else {
            return false
        }
    }
}

struct FlashView_Previews: PreviewProvider {
    static var previews: some View {
        FlashView()
    }
}
