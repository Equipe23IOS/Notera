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
    @Binding var hasJustCreatedPassword: Bool
    @Binding var goToNotera: Bool
    @ObservedObject var passwordViewModel: PasswordViewModel
    
    var body: some View {
        ZStack {
            Color.canvas
                .ignoresSafeArea()
            
            VStack {
                if(hasJustCreatedPassword) {
                    Text("Insert the password you just created")
                        .font(.custom("Leorio", size: 24))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.caramel)
                } else {
                    Text("Welcome back!")
                        .font(.custom("Leorio", size: 24))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.caramel)
                }
                
                ZStack {
                    Group {
                        if(isSecure) {
                            TextField("Enter a password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .font(.custom("Leorio", size: 16))
                        } else {
                            SecureField("Enter a password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .font(.custom("Leorio", size: 16))
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
                    if(passwordViewModel.validatePasswrd(password)) {
                        goToNotera.toggle()
                    } else {
                        showPopup.toggle()
                    }
                }, label: {
                    Capsule()
                        .fill(Color.toast)
                        .frame(width: 160, height: 40)
                        .overlay() {
                            Text("Log in")
                                .font(.custom("Leorio", size: 20))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding()
                                .foregroundColor(.canvas)
                        }
                })
            }
        }
    }
}

