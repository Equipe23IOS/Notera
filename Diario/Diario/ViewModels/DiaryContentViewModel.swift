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
    }
    
    func createEntry (_ title: String, _ entry: String, _ notebookID: UUID?) {
        guard let notebookID = notebookID else {
            return print("something went wrong")
        }
        
        let page = DiaryContent(title: title, entry: entry)
        
        guard let index = notebooksViewModel.notebooks.firstIndex(where: { i in
            i.id == notebookID
        }) else {
            return print("Error")
        }
        
        notebooksViewModel.notebooks[index].entries.append(page)
        loadRecentEntries(page)
        print(notebooksViewModel.notebooks[index].entries)
    }
    
    func updateDiaryPage(_ title: String, _ entry: String, _ pageID: UUID, _ notebookID: UUID) {
        let notebookIndex = notebooksViewModel.notebooks.firstIndex { i in
            i.id == notebookID
        }
        
        guard let notebookIndex = notebookIndex else {
            return print("Notebook not found")
        }
        
        for i in notebooksViewModel.notebooks {
            for j in i.entries {
                if(j.id == pageID) {
                    let pageIndex = i.entries.firstIndex { i in
                        i.id == j.id
                    }
                    notebooksViewModel.notebooks[notebookIndex].entries[pageIndex!].title = title
                    notebooksViewModel.notebooks[notebookIndex].entries[pageIndex!].entry = entry
                }
            }
        }
    }
    
    func updateRecentEntries(_ title: String, _ entry: String, _ pageID: UUID?) {
        let pageID = recentEntries.firstIndex { i in
            i.id == pageID
        }
        
        guard let pageID = pageID else {
            return print("Erro em updateRecentEntries")
        }
        
        recentEntries[pageID].title = title
        recentEntries[pageID].entry = entry
    }
    
    func loadRecentEntries(_ entry: DiaryContent) {
        recentEntries.append(entry)
    }
}
