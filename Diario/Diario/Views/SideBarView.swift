//
//  SideBarView.swift
//  Diario
//
//  Created by iredefbmac_36 on 18/08/25.
//

import SwiftUI

struct SideBarView: View {
    @AppStorage("selectedTheme") var selectedTheme: String = "System"
    @Environment(\.appsTheme) var appsTheme
    @State var selectedLanguage: String = "English"
    var languages: [String] = ["English", "Portugues", "Espanhol", "日本"]
    var appTheme: [String] = ["System", "Light", "Dark"]
    
    func evaluateAppsTheme() {
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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Colors.backgroundColor
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    TitleComponent(title: "Settings", weight: .bold)
                    
                    HStack {
                        Image(systemName: "globe")
                            .font(.system(size: 28))
                            .foregroundColor(Colors.textColor)
                        
                        TextComponent(text: "Language:", size: 20)
                        
                        Picker(selectedLanguage, selection: $selectedLanguage) {
                            ForEach(languages, id: \.self) { i in
                                Text(i)
                            }
                        }
                        .tint(Colors.textColor)
                    }
                    
                    HStack {
                        Image(systemName: selectedTheme == "Light" ? "sun.max.fill" : "moon.fill")
                            .font(.system(size: 28))
                            .foregroundColor(Colors.textColor)
                        
                        TextComponent(text: "Change theme:", size: 20)
                        
                        Picker(selectedTheme, selection: $selectedTheme) {
                            ForEach(appTheme, id: \.self) { i in
                                Text(i)
                            }
                        }
                        .tint(Colors.textColor)
                        .onChange(of: selectedTheme) {
                            evaluateAppsTheme()
                        }
                    }
                    
                    HStack {
                        Image(systemName: "quote.bubble.fill")
                            .font(.system(size: 28))
                            .foregroundColor(Colors.textColor)
                        
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
