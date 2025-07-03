//
//  DiaryContentView.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/05/25.
//

import SwiftUI

class DiaryContentViewModel: ObservableObject {
    @AppStorage("diaryEntries") var storedEntries: String = ""
    @Published var entries: [DiaryContent] = []
    @ObservedObject var notebooksViewModel: NotebooksViewModel
    
    init(notebooksViewModel: NotebooksViewModel) {
        self.notebooksViewModel = notebooksViewModel
        loadEntries()
    }
    
    func createEntry (_ title: String, _ entry: String, _ notebookID: UUID?) {
        
        guard let teste = notebookID else {
            return print("teste")
        }
        
        let page = DiaryContent(title: title, entry: entry)
        
        guard let index = notebooksViewModel.notebooks.firstIndex(where: { i in
            i.id == teste
        }) else {
            return print("Error")
        }
        
        notebooksViewModel.notebooks[index].entries.append(page)
        print(notebooksViewModel.notebooks[index].entries)
    }
    
    func updateDiaryPage(_ title: String, _ entry: String, indexOfPage: Int) {
        entries[indexOfPage] = DiaryContent(title: title, entry: entry)
        entries = entries
        storedEntries = String(data: try! JSONEncoder().encode(entries), encoding: .utf8) ?? ""
    }
    
    func loadEntries() {
        guard !storedEntries.isEmpty, let data = storedEntries.data(using: .utf8) else {
            return print("storedEntries is empty or invalid")
        }
        
        do {
            let decoded = try JSONDecoder().decode([DiaryContent].self, from: data)
            entries.append(contentsOf: decoded)
        } catch {
            print("error decoding jason file")
            storedEntries = ""
        }
    }
}
