//
//  EnvironmentKeys.swift
//  Diario
//
//  Created by iredefbmac_36 on 26/08/25.
//

import SwiftUI

struct AppsThemeKey: EnvironmentKey {
    static let defaultValue: Binding<ColorScheme?>? = nil
}

extension EnvironmentValues {
    var appsTheme: Binding<ColorScheme?>? {
        get { self[AppsThemeKey.self] }
        set { self[AppsThemeKey.self] = newValue }
    }
}
