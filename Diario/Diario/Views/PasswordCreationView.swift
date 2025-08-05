//
//  PasswordView.swift
//  Diario
//
//  Created by iredefbmac_36 on 24/07/25.
//

import SwiftUI

struct PasswordCreationView: View {
    @State var password: String = ""
    @State var isSecure: Bool = false
    @AppStorage("goToValidation") var goToValidation: Bool = false
    @Binding var hasJustCreatedPassword: Bool
    @ObservedObject var passwordViewModel: PasswordViewModel
    
    var body: some View {
        ZStack {
            Color.canvas
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Password")
                    .foregroundColor(.espresso)
                    .font(.custom("Leorio", size: 36))
                    .fontWeight(.bold)
                    .padding()
                
                Text("To protect your notebooks, set a password!")
                    .foregroundColor(.espresso)
                    .font(.custom("Leorio", size: 24))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                ZStack {
                    Group {
                        if(isSecure) {
                            TextField("Enter a password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .font(.custom("Leorio", size: 20))
                        } else {
                            SecureField("Enter a password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .font(.custom("Leorio", size: 20))
                        }
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isSecure.toggle()
                        }, label: {
                            Image(systemName: isSecure ? "eye" : "eye.slash")
                                .foregroundColor(.toast)
                        })
                    }
                    .padding()
                    .padding(.trailing, 10)
                }
                
                Button(action: {
                    passwordViewModel.createPassword(password)
                    goToValidation.toggle()
                    hasJustCreatedPassword.toggle()
                }, label: {
                    Capsule()
                        .fill(Color.toast)
                        .frame(width: 200, height: 40)
                        .overlay() {
                            Text("Create password")
                                .padding()
                                .font(.custom("Leorio", size: 20))
                                .fontWeight(.medium)
                                .foregroundColor(.linen)
                        }
                })
                .padding()
            }
        }
    }
}
