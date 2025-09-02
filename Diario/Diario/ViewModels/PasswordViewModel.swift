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
    
    //Criar ou definir a senha do usuário
    func createPassword(_ password: String) {
        //Regra: salva a senha no keychain com a chave "userPassword"
        keychain.set(password, forKey: "userPassword")
    }

    //Validar se a senha informada é igual à armazenada
    func validatePasswrd(_ password: String) -> Bool {
        //Regra: retorna verdadeiro se a senha informada bate com a do keychain
        return keychain.get("userPassword") == password
    }

    //Alterar a senha existente
    func changePassword(_ newPassword: String) {
        //Regra: atualiza a senha no keychain com a nova senha
        keychain.set(newPassword, forKey: "userPassword")
    }
}
