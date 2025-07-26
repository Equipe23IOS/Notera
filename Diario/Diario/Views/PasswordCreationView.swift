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
    @StateObject var passwordViewModel: PasswordViewModel = PasswordViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Password")
                .font(.custom("Georgia", size: 25))
            
            Text("To protect your notebooks, set a password!")
                .font(.custom("Georgia", size: 20))
            
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
                        if(isSecure) {
                            Image(systemName: "eye.slash")
                        } else {
                            Image(systemName: "eye")
                        }
                    })
                }
                .padding()
                .padding(.trailing, 10)
            }
            
            Button(action: {
                passwordViewModel.createPassword(password)
            }, label: {
                Text("Create password")
                    .font(.custom("Georgia", size: 22))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.toast)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            })
            .padding()
        }
    }
}

#Preview {
    PasswordCreationView()
}
