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
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                
                VStack(spacing: 12) {
                    TitleComponent(title: "Credits", weight: .bold, size: 36)
                        .padding(.bottom, 20)
                    
                    TitleComponent(title: "A product of:", weight: .bold, size: 36)
                    TextComponent(text: "Notera", size: 28)
                        .padding(.bottom, 20)
                    
                    TitleComponent(title: "Developed by:", weight: .bold, size: 36)
                    TextComponent(text: "Bell Marques", size: 28)
                        .padding(.bottom, 20)
                    
                    TitleComponent(title: "UI/UX design:", weight: .bold, size: 36)
                    TextComponent(text: "Atila Benoit", size: 28)
                        .padding(.bottom, 20)
                    
                    TitleComponent(title: "Support:", weight: .bold, size: 36)
                    TextComponent(text: "Guilherme Alfredo", size: 28)
                        .padding(.bottom, 20)
                    
                    TitleComponent(title: "Art:", weight: .bold, size: 36)
                    TextComponent(text: "Bell Marques", size: 28)
                        .padding(.bottom, 20)
                    
                    TitleComponent(title: "Special thanks to", weight: .bold, size: 36)
                    TextComponent(text: "My dearest friends", size: 28)
                    TextComponent(text: "Gleide Dias", size: 28)
                    TextComponent(text: "Lavyne Dias", size: 28)
                    TextComponent(text: "Edimario Mendes", size: 28)
                        .padding(.bottom, 20)
                    
                    TextComponent(text: "© 2025 Notera. All Rights Reserved.", size: 20)
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
                                    .foregroundColor(Color("ButtonColor"))
                                
                                Text("Back")
                                    .foregroundColor(Color("ButtonColor"))
                                    .font(.custom("Leorio", size: 20))
                            }
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    CreditsView()
}
