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
                            Text(page.label)
                                .font(.custom("Leorio", size: 36))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.caramel)

                            Text(page.text)
                                .font(.custom("Leorio", size: 20))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding()
                                .foregroundColor(.caramel)
                        }
                    }
                }

                Button {
                    hasSeenWelcome = true
                } label: {
                    Capsule()
                        .fill(Color.toast)
                        .frame(width: 160, height: 40)
                        .overlay() {
                            Text("Get Started")
                                .padding()
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.linen)
                        }
                }
            }
            .tabViewStyle(.page)
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = .label
                UIPageControl.appearance().pageIndicatorTintColor = .caramel
            }
        }
    }
}
