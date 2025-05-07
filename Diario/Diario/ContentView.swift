//
//  ContentView.swift
//  Diario
//
//  Created by iredefbmac_36 on 05/05/25.
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
        if let data = storedEntries.data(using: .utf8) {
            let decoded = try! JSONDecoder().decode([DiaryContent].self, from: data)
            entries.append(contentsOf: decoded)
        }
    }
}

struct DiaryContent: Codable {
    var title: String
    var entry: String
}

struct ContentView: View {
    @StateObject var diaryContentView = DiaryContentView()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Entries")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        Diary(diaryContentView: diaryContentView)
                    }, label: {
                        Text("New")
                    })
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct Diary: View {
    @State private var diaryTitle: String = ""
    @State private var diaryEntry: String = ""
    @ObservedObject var diaryContentView: DiaryContentView
    
    var body: some View {
        VStack {
            TextField("Title", text: $diaryTitle)
                .font(.title)
            
            TextField("Write your ideas", text: $diaryEntry)
            
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    diaryContentView.createEntry(diaryTitle, diaryEntry)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
