//
//  PasswordViewModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 25/07/25.
//

import SwiftUI
import KeychainSwift

class PasswordViewModel: ObservableObject {
    let keychain = KeychainSwift()
    
    func createPassword(_ password: String) {
        keychain.set(password, forKey: "userPassword")
    }
    
    func validatePasswrd(_ password: String) -> Bool {
        return keychain.get("userPassword") == password
    }
    
    func changePassword(_ newPassword: String) {
        keychain.set(newPassword, forKey: "userPassword")
    }
}
