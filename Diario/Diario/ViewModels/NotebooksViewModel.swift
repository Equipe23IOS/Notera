//
//  NotebooksViewModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 01/06/25.
//

import SwiftUI

class NotebooksViewModel: ObservableObject {
    @Published var notebooks: [NotebookModel] = []
    
    func createNotebook(_ name: String) {
        let notebook = NotebookModel(name: name)
        notebooks.append(notebook)
        print(notebooks)
    }
    
    func deleteNotebook(_ notebookID: UUID) {
        guard let notebookIndex = notebooks.firstIndex(where: { $0.id == notebookID }) else {
            return
        }
        
        notebooks.remove(at: notebookIndex)
    }
}
