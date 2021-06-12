//
//  AlertView.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 12.06.2021.
//

import SwiftUI

struct AlertView: View {
    
    let model : AlertModel
    
    @State private var isAppeared : Bool = false
    
    var body: some View {
        
        VStack {
            ZStack {
                if let vm = model.alertType.subviewModel {
                    AlertSubview(model: vm)
                        .offset(
                            CGSize(
                                width: 0,
                                height: isAppeared ? 37 :
                                    -70
                            )
                        )
                }
                AlertContentView(model: model)
                    .offset(
                        CGSize(
                            width: 0,
                            height: isAppeared ? 0 :
                                -70
                        )
                    )
            }
            .frame(maxHeight: 70)
            .onAppear {
                withAnimation {
                    isAppeared = true
                }
            }
            Spacer()
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(model: .test)
    }
}
