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

struct DiaryContent: Codable {
    var title: String
    var entry: String
}

struct ContentView: View {
    @StateObject var diaryContentView = DiaryContentView()
    
    func loadDiaryCards() -> some View {
        ScrollView {
            VStack {
                ForEach(diaryContentView.entries.indices, id: \.self) { i in
                    return DiaryCard(title: diaryContentView.entries[i].title)
                }
            }
        }
    }
    
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
                
                loadDiaryCards()
                
                Spacer()
            }
        }
    }
}

struct DiaryCard: View {
    @State var title: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 2)
            )
            .overlay(
                Text(title)
                    .foregroundColor(.black)
            )
            .padding(.horizontal, 10)
            .padding(.vertical, 1)
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
