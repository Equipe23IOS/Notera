//
//  DiaryContentView.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/05/25.
//

import SwiftUI

class DiaryContentViewModel: ObservableObject {
    @AppStorage("diaryEntries") var storedEntries: String = ""
    @Published var recentEntries: [DiaryContent] = []
    @ObservedObject var notebooksViewModel: NotebooksViewModel
    
    init(notebooksViewModel: NotebooksViewModel) {
        self.notebooksViewModel = notebooksViewModel
        loadRecentEntries()
    }
    
    //Criar uma nova página dentro de um caderno específico
    func createEntry (_ title: String, _ entry: String, _ notebookID: UUID?) {
        // Regra: só cria se houver um notebook válido
        guard let notebookID = notebookID else {
            return print("NotebookID is nil")
        }

        //Regra: só cria se o notebook existir na lista
        guard let index = notebooksViewModel.notebooks.firstIndex(where: { $0.id == notebookID }) else {
            return print("Notebook not found in list")
        }
        
        //Cria a página (título + texto)
        let page = DiaryContent(title: title, entry: entry)
        
        //Adiciona no caderno e também nos registros recentes
        notebooksViewModel.notebooks[index].entries.append(page)
        appendRecentEntries(page)
        print(notebooksViewModel.notebooks[index].entries)
    }

    //Atualizar uma página já existente
    func updateNotebook(_ title: String, _ entry: String, _ pageID: UUID, _ notebookID: UUID?) {
        //Regra: se o notebook e a página forem encontrados, atualiza diretamente
        guard let notebookIndex = notebooksViewModel.notebooks.firstIndex(where: { $0.id == notebookID }),
              let pageIndex = notebooksViewModel.notebooks[notebookIndex].entries.firstIndex(where: { $0.id == pageID })
        else {
            //Regra alternativa: se não achar o notebook, procura em todos
            for i in 0..<notebooksViewModel.notebooks.count {
                guard let pageIndex = notebooksViewModel.notebooks[i].entries.firstIndex(where: { $0.id == pageID })
                else {
                    print("Error in updateDiaryPage")
                    continue
                }
                
                //Atualiza título e texto da página encontrada
                notebooksViewModel.notebooks[i].entries[pageIndex].title = title
                notebooksViewModel.notebooks[i].entries[pageIndex].entry = entry
                return
            }
            return
        }
        
        //Atualiza título e texto da página no caderno correto
        notebooksViewModel.notebooks[notebookIndex].entries[pageIndex].title = title
        notebooksViewModel.notebooks[notebookIndex].entries[pageIndex].entry = entry
    }

    //Atualizar uma página que está na lista de entradas recentes
    func updateRecentEntries(_ title: String, _ entry: String, _ pageID: UUID?) {
        //Regra: só atualiza se a página existir nos recentes
        guard let pageIndex = recentEntries.firstIndex(where: { $0.id == pageID }) else {
            return print("Error in updateRecentEntries")
        }
        
        recentEntries[pageIndex].title = title
        recentEntries[pageIndex].entry = entry
    }

    //Adicionar uma entrada na lista de recentes
    func appendRecentEntries(_ entry: DiaryContent) {
        // Regra: sempre que criar ou mexer em uma página, ela vai pros recentes
        recentEntries.append(entry)
    }

    //Deletar uma página de dentro de um caderno
    func deleteEntryFromNotebook(_ pageID: UUID, _ notebookID: UUID?) {
        //Regra: se achar o caderno e a página dentro dele, deleta
        guard let notebookIndex = notebooksViewModel.notebooks.firstIndex(where: { $0.id == notebookID }),
              let pageIndex = notebooksViewModel.notebooks[notebookIndex].entries.firstIndex(where: { $0.id == pageID })
        else {
            //Regra alternativa: se não achar no caderno, procura em todos
            for i in 0..<notebooksViewModel.notebooks.count {
                guard let pageIndex = notebooksViewModel.notebooks[i].entries.firstIndex(where: { $0.id == pageID })
                else {
                    print("Error in updateDiaryPage")
                    continue
                }
                
                notebooksViewModel.notebooks[i].entries.remove(at: pageIndex)
                return
            }
            return
        }
        
        notebooksViewModel.notebooks[notebookIndex].entries.remove(at: pageIndex)
    }

    //Carregar todas as páginas já criadas para os recentes
    func loadRecentEntries() {
        //Regra: todos os cadernos contribuem com suas páginas para a lista de recentes
        for i in notebooksViewModel.notebooks {
            recentEntries.append(contentsOf: i.entries)
        }
    }

    //Deletar uma entrada dos recentes
    func deleteEntryFromRecentEntries(_ pageID: UUID) {
        //Regra: só deleta se a entrada estiver na lista de recentes
        guard let pageIndex = recentEntries.firstIndex(where: { $0.id == pageID }) else {
            return print("Error in deleteEntryFromRecentEntries")
        }
        
        recentEntries.remove(at: pageIndex)
    }

    //Avaliar quando um caderno é excluído
    func evaluateDeletedNotebook(_ notebookID: UUID) {
        //Regra: todas as entradas desse caderno também devem sumir dos recentes
        let notebookModel = notebooksViewModel.notebooks.filter({ $0.id == notebookID }).first
        
        for i in notebookModel!.entries {
            recentEntries.removeAll(where: { $0.id == i.id })
        }
    }
}
