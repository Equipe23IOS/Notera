//
//  PasswordValidationView.swift
//  Diario
//
//  Created by iredefbmac_36 on 26/07/25.
//

import SwiftUI

struct PasswordValidationView: View {
    @State var attempts: Int = 1
    @State var password: String = ""
    @State var isSecure: Bool = false
    @State var showPopup: Bool = false
    @Binding var hasJustCreatedPassword: Bool
    @Binding var goToNotera: Bool
    @ObservedObject var passwordViewModel: PasswordViewModel
    
    func countdown() {
        var remainingTime = 10
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            if(remainingTime == 0) {
                t.invalidate()
                attempts += 1
            }
            remainingTime -= 1
        }
    }
    
    var body: some View {
        ZStack {
            Color.canvas
                .ignoresSafeArea()
            
            if(attempts % 5 == 0) {
                EmptyView()
                
                Text("\(countdown())")
                    .hidden()
                
                TextComponent(text: "Try again in 30 seconds")
                
            } else {
                VStack {
                    if(hasJustCreatedPassword) {
                        TextComponent(text: "Insert the password you just created")
                        
                    } else {
                        TitleComponent(title: "Welcome back!", weight: .bold)
                    }
                    
                    ZStack {
                        Group {
                            if(isSecure) {
                                TextFieldComponent(text: "Enter a password", size: 16, textFieldVariable: $password)
                                    .padding()
                               
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
                    
                    ButtonComponent(text: "Log in", size: 20, width: 160, height: 40, shape: Capsule(), action: {
                        if(passwordViewModel.validatePasswrd(password)) {
                            goToNotera.toggle()
                        } else {
                            attempts += 1
                            showPopup.toggle()
                        }
                    })
                    
                    .alert("Error", isPresented: $showPopup) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("The password is wrong")
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var a = false
    PasswordValidationView(attempts: 1, password: "", isSecure: false, showPopup: false, hasJustCreatedPassword: $a, goToNotera: $a, passwordViewModel: PasswordViewModel())
}
