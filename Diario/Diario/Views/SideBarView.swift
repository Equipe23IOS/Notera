//
//  SideBarView.swift
//  Diario
//
//  Created by iredefbmac_36 on 18/08/25.
//

import SwiftUI

struct SideBarView: View {
    var languages: [String] = ["English", "Portugues", "Espanhol", "日本"]
    var appTheme: [String] = ["Light", "Dark"]
    @Binding var sidebarOpened: Bool
    @Binding var darkMode: Bool
    @State var selectedLanguage: String = "English"
    @State var selectedTheme: String = "Light"
    
    var body: some View {
        ZStack {
            Color.caramel
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                TitleComponent(title: "Settings", color: .canvas, weight: .bold)
                
                HStack {
                    Image(systemName: "globe")
                        .font(.system(size: 28))
                        .foregroundColor(.canvas)
                    
                    TextComponent(text: "Language:", color: .canvas, size: 20)
                    
                    Picker(selectedLanguage, selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { i in
                            Text(i)
                        }
                    }
                    .tint(.canvas)
                    
                }
                
                HStack {
                    Image(systemName: selectedTheme == "Light" ? "sun.max.fill" : "moon.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.canvas)
                    
                    TextComponent(text: "Change theme:", color: .canvas, size: 20)
                    
                    Picker(selectedTheme, selection: $selectedTheme) {
                        ForEach(appTheme, id: \.self) { i in
                            Text(i)
                        }
                    }
                    .tint(.canvas)
                }
                
                HStack {
                    Image(systemName: "quote.bubble.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.canvas)
                    
                    TextComponent(text: "Credits", color: .canvas, size: 20)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    @Previewable @State var a = true
    SideBarView(sidebarOpened: $a, darkMode: $a, selectedLanguage: "English")
}
