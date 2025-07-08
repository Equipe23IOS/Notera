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
        loadEntries()
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
        print(notebooksViewModel.notebooks[index].entries)
    }
    
    func updateDiaryPage(_ title: String, _ entry: String, _ indexOfPage: Int, _ notebookID: UUID) {
        let notebookID = notebooksViewModel.notebooks.firstIndex { i in
            i.id == notebookID
        }
        
        guard let notebookID = notebookID else {
            return print("Something went wrong updating this page")
        }
        
        notebooksViewModel.notebooks[notebookID].entries[indexOfPage].title = title
        notebooksViewModel.notebooks[notebookID].entries[indexOfPage].entry = entry
    }
    
    func loadEntries() {
        guard !storedEntries.isEmpty, let data = storedEntries.data(using: .utf8) else {
            return print("storedEntries is empty or invalid")
        }
        
        do {
            let decoded = try JSONDecoder().decode([DiaryContent].self, from: data)
            recentEntries.append(contentsOf: decoded)
        } catch {
            print("error decoding jason file")
            storedEntries = ""
        }
    }
}
