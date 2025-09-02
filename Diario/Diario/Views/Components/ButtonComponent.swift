//
//  ButtonComponent.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/08/25.
//

import SwiftUI

struct ButtonComponent<form: Shape>: View {
    var text: String
    var color: Color = Colors.buttonTextColor
    var shapeColor: Color = Colors.buttonColor
    var size: CGFloat
    var width: CGFloat
    var height: CGFloat
    var shape: form
    var action: () -> Void
    var overlay: (() -> AnyView)? = nil
   
    var body: some View {
        Button(action: {
            action()
        }, label: {
            shape
                .fill(shapeColor)
                .frame(width: width, height: height)
                .overlay() {
                    Group {
                        if let overlay = overlay {
                            overlay()
                        } else {
                            Text(text)
                                .foregroundColor(color)
                                .fontWeight(.medium)
                                .font(.custom("Leorio", size: size))
                        }
                    }
                }
        })
    }
}


