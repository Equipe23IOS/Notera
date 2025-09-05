//
//  PasswordFlowView.swift
//  Diario
//
//  Created by iredefbmac_36 on 28/07/25.
//

import SwiftUI

struct PasswordFlowView: View {
    @State var goToNotera: Bool = false
    @State var hasJustCreatedPassword: Bool = false
    @AppStorage("goToValidation") var goToValidation: Bool = false
    @StateObject var passwordViewModel: PasswordViewModel = PasswordViewModel()
    
    var body: some View {
        Group {
            if(goToNotera) {
                ContentView()
            } else if(goToValidation) {
                PasswordValidationView(hasJustCreatedPassword: $hasJustCreatedPassword, goToNotera: $goToNotera, passwordViewModel: passwordViewModel)
            } else {
                PasswordCreationView(passwordViewModel: passwordViewModel, hasJustCreatedPassword: $hasJustCreatedPassword)
            }
        }
    }
}
