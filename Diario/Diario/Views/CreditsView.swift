//
//  CreditsView.swift
//  Diario
//
//  Created by iredefbmac_36 on 21/08/25.
//

import SwiftUI

struct CreditsView: View {
    @State var animation: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                TitleComponent(title: "Credits", color: .espresso, weight: .bold, size: 36)
                    .padding(.bottom, 20)
                
                TitleComponent(title: "A product of:", color: .espresso, weight: .bold, size: 36)
                TextComponent(text: "Notera", color: .espresso, size: 28)
                    .padding(.bottom, 20)
                
                TitleComponent(title: "Developed by:", color: .espresso, weight: .bold, size: 36)
                TextComponent(text: "Bell Marques", color: .espresso, size: 28)
                    .padding(.bottom, 20)
                
                TitleComponent(title: "UI/UX design:", color: .espresso, weight: .bold, size: 36)
                TextComponent(text: "Atila Benoit", color: .espresso, size: 28)
                    .padding(.bottom, 20)
                
                TitleComponent(title: "Support:", color: .espresso, weight: .bold, size: 36)
                TextComponent(text: "Guilherme Alfredo", color: .espresso, size: 28)
                    .padding(.bottom, 20)
                
                TitleComponent(title: "Art:", color: .espresso, weight: .bold, size: 36)
                TextComponent(text: "Bell Marques", color: .espresso, size: 28)
                    .padding(.bottom, 20)
                
                TitleComponent(title: "Special thanks to", color: .espresso, weight: .bold, size: 36)
                TextComponent(text: "My dearest friends", color: .espresso, size: 28)
                TextComponent(text: "Gleide Dias", color: .espresso, size: 28)
                TextComponent(text: "Lavyne Dias", color: .espresso, size: 28)
                TextComponent(text: "Edimario Mendes", color: .espresso, size: 28)
                    .padding(.bottom, 20)
                
                TextComponent(text: "© 2025 Notera. All Rights Reserved.", color: .espresso, size: 20)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
            .offset(y: animation ? 0 : 1000)
            .animation(.linear(duration: 8), value: animation)
            .navigationBarBackButtonHidden(true)
            .onAppear() {
                animation.toggle()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.toast)
                            
                            Text("Back")
                                .foregroundColor(.toast)
                                .font(.custom("Leorio", size: 20))
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    CreditsView()
}
