//
//  SideBarView.swift
//  Diario
//
//  Created by iredefbmac_36 on 18/08/25.
//

import SwiftUI

struct SideBarView: View {
    var languages: [String] = ["English", "Portugues", "Espanhol", "日本"]
    var appTheme: [String] = ["System", "Light", "Dark"]
    @Binding var sidebarOpened: Bool
    @Binding var darkMode: Bool
    @State var selectedLanguage: String = "English"
    @State var selectedTheme: String = "Light"
    @Environment(\.appsTheme) var appsTheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    TitleComponent(title: "Settings", weight: .bold)
                    
                    HStack {
                        Image(systemName: "globe")
                            .font(.system(size: 28))
                            .foregroundColor(.canvas)
                        
                        TextComponent(text: "Language:", size: 20)
                        
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
                        
                        TextComponent(text: "Change theme:", size: 20)
                        
                        Picker(selectedTheme, selection: $selectedTheme) {
                            ForEach(appTheme, id: \.self) { i in
                                Text(i)
                            }
                        }
                        .tint(.canvas)
                        .onChange(of: selectedTheme) {
                            switch selectedTheme {
                            case "System":
                                appsTheme?.wrappedValue = nil
                            case "Dark":
                                appsTheme?.wrappedValue = .dark
                            case "Light":
                                appsTheme?.wrappedValue = .light
                            default:
                                appsTheme?.wrappedValue = nil
                            }
                        }
                    }
                    
                    HStack {
                        Image(systemName: "quote.bubble.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.canvas)
                        
                        NavigationLink(destination: CreditsView()) {
                            TextComponent(text: "Credits", size: 20)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}
