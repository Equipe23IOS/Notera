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
    
    //Criar um novo caderno com nome e sprite
    func createNotebook(_ name: String, _ sprite: String) {
        //Regra: cria o modelo do caderno com nome e sprite informados
        let notebook = NotebookModel(name: name, sprite: sprite)
        //Regra: adiciona o caderno à lista de cadernos em memória
        notebooks.append(notebook)
        //Regra: salva o caderno no banco de dados
        database.appendNotebook(notebook: notebook)
        print(database.fetchNotebooks())
    }

    //Excluir um caderno existente pelo ID
    func deleteNotebook(_ notebookID: UUID) {
        //Regra: só remove se o caderno existir na lista em memória
        guard let notebookIndex = notebooks.firstIndex(where: { $0.id == notebookID }) else {
            return
        }
        
        //Regra: remove o caderno da lista em memória
        notebooks.remove(at: notebookIndex)
        
        //Regra: busca o caderno no banco de dados para confirmar exclusão
        guard let deletedNotebook = database.fetchNotebooks().first(where: { fetchedNotebook in
            fetchedNotebook.id == notebookID
        }) else {
            return
        }
        
        //Regra: remove o caderno do banco de dados
        database.deleteNotebook(notebook: deletedNotebook)
    }
}
