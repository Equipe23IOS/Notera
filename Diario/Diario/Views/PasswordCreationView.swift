//
//  PasswordView.swift
//  Diario
//
//  Created by iredefbmac_36 on 24/07/25.
//

import SwiftUI

struct PasswordCreationView: View {
    @AppStorage("goToValidation") var goToValidation: Bool = false
    @ObservedObject var passwordViewModel: PasswordViewModel
    @Binding var hasJustCreatedPassword: Bool
    @State var password: String = ""
    @State var isSecure: Bool = false
    
    var body: some View {
        ZStack {
            Colors.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                TitleComponent(title: "Password", weight: .bold)
                
                TextComponent(text: "To protect your notebooks, set a password!", size: 24)
                
                ZStack {
                    Group {
                        if(isSecure) {
                            TextFieldComponent(text: "Enter a password", size: 20, textFieldVariable: $password)
                        } else {
                            SecureField("Enter a password", text: $password)
                                .textFieldStyle(.plain)
                                .padding(8)
                                .font(.custom("Leorio", size: 16))
                                .foregroundColor(Colors.textColor)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Colors.backgroundColor.opacity(0.2))
                                        .stroke(Colors.textColor, lineWidth: 2)
                                )
                        }
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isSecure.toggle()
                        }, label: {
                            Image(systemName: isSecure ? "eye" : "eye.slash")
                                .foregroundColor(Colors.buttonColor)
                        })
                    }
                    .padding()
                    .padding(.trailing, 10)
                }
                
                ButtonComponent(text: "Create password", size: 20, width: 160, height: 40, shape: Capsule(), action: {
                    passwordViewModel.createPassword(password)
                    goToValidation.toggle()
                    hasJustCreatedPassword.toggle()
                })
                .padding()
            }
        }
    }
}
