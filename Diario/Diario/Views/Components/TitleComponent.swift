//
//  TitleComponent.swift
//  Diario
//
//  Created by iredefbmac_36 on 10/08/25.
//

import SwiftUI

struct TitleComponent: View {
    var title: String
    var color: Color = Color("TextColor")
    var weight: Font.Weight
    var size: CGFloat = 36
    
    var body: some View {
        Text(title)
            .font(.custom("Leorio", size: size))
            .foregroundColor(color)
            .fontWeight(weight)
    }
}
