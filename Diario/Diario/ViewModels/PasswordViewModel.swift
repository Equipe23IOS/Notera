//
//  PasswordViewModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 25/07/25.
//

import SwiftUI

class PasswordViewModel: ObservableObject {
    var userPassword: String = ""
    
    func createPassword(_ password: String) {
        userPassword = password
    }
    
    func validatePasswrd(_ password: String) -> Bool {
        return password == userPassword
    }
}
