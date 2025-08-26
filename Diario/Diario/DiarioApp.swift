//
//  DiarioApp.swift
//  Diario
//
//  Created by iredefbmac_36 on 05/05/25.
//

import SwiftUI
import SwiftData

@main
struct DiarioApp: App {
    var container: ModelContainer {
        let schema = Schema([NotebookModel.self, DayModel.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
        let container = try! ModelContainer(for: schema, configurations: configuration)
        return container
    }
    
    @State var appsTheme: ColorScheme? = nil
    
    var body: some Scene {
        WindowGroup {
            OnBoardingView()
                .preferredColorScheme(appsTheme)
                .environment(\.appsTheme, $appsTheme)
        }
        .modelContainer(container)
    }
}
