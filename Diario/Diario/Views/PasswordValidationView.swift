//
//  PasswordValidationView.swift
//  Diario
//
//  Created by iredefbmac_36 on 26/07/25.
//

import SwiftUI

struct PasswordValidationView: View {
    @State var password: String = ""
    @State var isSecure: Bool = false
    @State var showPopup: Bool = false
    @Binding var goToNotera: Bool
    @ObservedObject var passwordViewModel: PasswordViewModel
    
    var body: some View {
        Text("Welcome back!")
        
        ZStack {
            Group {
                if(isSecure) {
                    TextField("Enter a password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                } else {
                    SecureField("Enter a password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    isSecure.toggle()
                }, label: {
                    Image(systemName: isSecure ? "eye" : "eye.slash")
                })
            }
            .padding()
            .padding(.trailing, 10)
        }
        
        Button(action: {
            if(passwordViewModel.validatePasswrd(password)) {
                goToNotera.toggle()
            } else {
                showPopup.toggle()
            }
        }, label: {
            Text("Log in")
        })
    }
}
