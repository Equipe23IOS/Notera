//
//  PasswordView.swift
//  Diario
//
//  Created by iredefbmac_36 on 24/07/25.
//

import SwiftUI

struct PasswordView: View {
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Password")
                .font(.custom("Georgia", size: 25))
            
            Text("To protect your notebooks, set a password!")
                .font(.custom("Georgia", size: 20))
            
            SecureField("Enter a password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                
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
    PasswordView()
}
