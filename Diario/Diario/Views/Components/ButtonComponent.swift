//
//  ButtonComponent.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/08/25.
//

import SwiftUI

struct ButtonComponent: View {
    var text: String
    var color: Color
    var size: CGFloat
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
   
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Capsule()
                .fill(Color.toast)
                .frame(width: width, height: height)
                .overlay() {
                    Text(text)
                        .foregroundColor(.canvas)
                        .fontWeight(.medium)
                        .font(.custom("Leorio", size: size))
                }
        })
    }
}


