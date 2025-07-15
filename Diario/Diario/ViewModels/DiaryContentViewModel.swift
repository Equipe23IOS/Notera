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
            return print("NotebookID is nil")
        }

        guard let index = notebooksViewModel.notebooks.firstIndex(where: { $0.id == notebookID }) else {
            return print("Notebook not found in list")
        }
        
        let page = DiaryContent(title: title, entry: entry)
        
        notebooksViewModel.notebooks[index].entries.append(page)
        loadRecentEntries(page)
        print(notebooksViewModel.notebooks[index].entries)
    }
    
    func updateNotebook(_ title: String, _ entry: String, _ pageID: UUID, _ notebookID: UUID?) {
        guard let notebookIndex = notebooksViewModel.notebooks.firstIndex(where: { $0.id == notebookID }),
              let pageIndex = notebooksViewModel.notebooks[notebookIndex].entries.firstIndex(where: { $0.id == pageID })
        else {
            for i in 0..<notebooksViewModel.notebooks.count {
                guard let pageIndex = notebooksViewModel.notebooks[i].entries.firstIndex(where: { $0.id == pageID })
                else {
                    print("Error in updateDiaryPage")
                    continue
                }
                
                notebooksViewModel.notebooks[i].entries[pageIndex].title = title
                notebooksViewModel.notebooks[i].entries[pageIndex].entry = entry
                return
            }
            return
        }
        
        notebooksViewModel.notebooks[notebookIndex].entries[pageIndex].title = title
        notebooksViewModel.notebooks[notebookIndex].entries[pageIndex].entry = entry
    }
    
    func updateRecentEntries(_ title: String, _ entry: String, _ pageID: UUID?) {
        guard let pageIndex = recentEntries.firstIndex(where: { $0.id == pageID }) else {
            return print("Error in updateRecentEntries")
        }
        
        recentEntries[pageIndex].title = title
        recentEntries[pageIndex].entry = entry
    }
    
    func loadRecentEntries(_ entry: DiaryContent) {
        recentEntries.append(entry)
    }
    
    func deleteEntryFromNotebook(_ pageID: UUID, _ notebookID: UUID) {
        guard let notebookIndex = notebooksViewModel.notebooks.firstIndex(where: { $0.id == notebookID }),
              let pageIndex = notebooksViewModel.notebooks[notebookIndex].entries.firstIndex(where: { $0.id == pageID })
        else {
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
    
    func deleteEntryFromRecentEntries(_ pageID: UUID) {
        guard let pageIndex = recentEntries.firstIndex(where: { $0.id == pageID }) else {
            return print("Error in deleteEntryFromRecentEntries")
        }
        
        recentEntries.remove(at: pageIndex)
    }
}
