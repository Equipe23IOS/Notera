//
//  PasswordFlowView.swift
//  Diario
//
//  Created by iredefbmac_36 on 28/07/25.
//

import SwiftUI

struct PasswordFlowView: View {
    @StateObject var passwordViewModel: PasswordViewModel = PasswordViewModel()
    
    var body: some View {
        if(passwordViewModel.keychain.get("userPassword") == nil) {
            PasswordCreationView(passwordViewModel: passwordViewModel)
        } else {
            PasswordValidationView(passwordViewModel: passwordViewModel)
        }
    }
}
