//
//  DiaryContentView.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/05/25.
//

import SwiftUI

class DiaryContentView: ObservableObject {
    @AppStorage("diaryEntries") var storedEntries: String = ""
    @Published var entries: [DiaryContent] = []
    
    init() {
        loadEntries()
    }
    
    func createEntry (_ title: String, _ entry: String) {
        let page = DiaryContent(title: title, entry: entry)
        entries.append(page)
        storedEntries = String(data: try! JSONEncoder().encode(entries), encoding: .utf8) ?? ""
        print(storedEntries)
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
