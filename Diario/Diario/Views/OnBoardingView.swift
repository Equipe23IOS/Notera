//  OnBoardingView.swift
//  Apresentação do App
//  Created by iredefbmac_36

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("hasSeenWelcome") var hasSeenWelcome: Bool = false
    
    var body: some View {
        if hasSeenWelcome {
            PasswordFlowView()
        }
        else {
            WelcomeView()
        }
    }
}
