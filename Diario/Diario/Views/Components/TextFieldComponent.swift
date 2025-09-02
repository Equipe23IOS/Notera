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
    @Binding var textFieldVariable: String
    
    var body: some View {
        TextField(text, text: $textFieldVariable)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .font(.custom("Leorio", size: size))
            .foregroundColor(color)
    }
}
