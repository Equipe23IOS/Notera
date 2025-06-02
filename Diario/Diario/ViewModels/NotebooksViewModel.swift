//
//  NotebooksViewModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 01/06/25.
//

import SwiftUI

class NotebooksViewModel: ObservableObject {
    @Published var notebooks: [NotebookModel] = []
    
    func createNotebook() {
        let notebook = NotebookModel()
        notebooks.append(notebook)
        print(notebooks)
    }
}
