//
//  NotebooksViewModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 01/06/25.
//

import SwiftUI
import SwiftData

class NotebooksViewModel: ObservableObject {
    let database = DataSource.shared
    @Published var notebooks: [NotebookModel]
    
    init() {
        self.notebooks = database.fetchNotebooks()
    }
    
    func createNotebook(_ name: String, _ sprite: String) {
        let notebook = NotebookModel(name: name, sprite: sprite)
        notebooks.append(notebook)
        database.appendNotebook(notebook: notebook)
        print(database.fetchNotebooks())
    }
    
    func deleteNotebook(_ notebookID: UUID) {
        guard let notebookIndex = notebooks.firstIndex(where: { $0.id == notebookID }) else {
            return
        }
        
        notebooks.remove(at: notebookIndex)
        guard let deletedNotebook = database.fetchNotebooks().first(where: { fetchedNotebook in
            fetchedNotebook.id == notebookID
        }) else {
            return
        }
        
        database.deleteNotebook(notebook: deletedNotebook)
    }
}
