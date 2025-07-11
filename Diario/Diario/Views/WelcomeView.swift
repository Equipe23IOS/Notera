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
        VStack {
            TabView {
                ForEach(WelcomeData.pages) { page in
                    VStack {
                        Text(page.label)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)

                        Text(page.text)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
            }

            Button {
                hasSeenWelcome = true
            } label: {
                Text("Get Started")
                    .font(.title3)
                    .fontWeight(.medium)
            }
        }
        .tabViewStyle(.page)
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .label
            UIPageControl.appearance().pageIndicatorTintColor = .systemGray
        }
    }
}

