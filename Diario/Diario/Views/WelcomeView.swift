//
//  WelcomeView.swift
//  Diario
//
//  Created by iredefbmac_36 on 11/07/25.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("hasSeenWelcome") var hasSeenWelcome: Bool = false
    
    var body: some View {
        ZStack {
            Color.canvas
                .ignoresSafeArea()
            
            VStack {
                TabView {
                    ForEach(WelcomeData.pages) { page in
                        VStack {
                            TitleComponent(title: page.label, weight: .bold)
                            
                            TextComponent(text: page.text)
                        }
                    }
                }

                ButtonComponent(text: "Get Started", size: 24, width: 160, height: 40, shape: Capsule(), action: {
                    hasSeenWelcome = true
                })
                
                
            }
            .tabViewStyle(.page)
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = .label
                UIPageControl.appearance().pageIndicatorTintColor = .caramel
            }
        }
    }
}
