//
//  SideBarViewModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 24/08/25.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("selectedScheme") var selectedScheme: String = "System"
    
    func viewScheme() -> ColorScheme? {
        switch selectedScheme {
        case "Light": return .light
            
        case "Dark": return .dark
            
        default: return nil
        }
    }
    
    func setScheme(_ scheme: String) {
        selectedScheme = scheme
    }
}
