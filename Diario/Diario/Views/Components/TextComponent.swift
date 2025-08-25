//
//  TextComponent.swift
//  Diario
//
//  Created by iredefbmac_36 on 10/08/25.
//

import SwiftUI

struct TextComponent: View {
    var text: String
    var color: Color = Color("textColor")
    var size: CGFloat = 16
    
    var body: some View {
        Text(text)
            .font(.custom("Leorio", size: size))
            .foregroundColor(color)
            .multilineTextAlignment(.center)
    }
}
