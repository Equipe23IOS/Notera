//
//  TextFieldComponent.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/08/25.
//

import SwiftUI

struct  TextFieldComponent: View {
    var text: String
    var size: CGFloat
    var color: Color = Colors.textColor
    var hideStroke: Bool = false
    @Binding var textFieldVariable: String
    
    var body: some View {
        TextField(text, text: $textFieldVariable)
            .textFieldStyle(.plain)
            .padding(8)
            .font(.custom("Leorio", size: size))
            .foregroundColor(color)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Colors.backgroundColor.opacity(0.2))
                    .stroke(hideStroke ? Color.clear : Colors.textColor, lineWidth: 2)
            )
    }
}
