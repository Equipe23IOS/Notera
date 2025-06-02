//
//  ContentView.swift
//  Diario
//
//  Created by iredefbmac_36 on 05/05/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var diaryContentView = DiaryContentView()
    @StateObject var notebookViewModel = NotebooksViewModel()
    
    func loadDiaryCards() -> some View {
        ScrollView {
            VStack {
                ForEach(diaryContentView.entries.indices, id: \.self) { i in
                    return DiaryCard(title: $diaryContentView.entries[i].title, index: i,diaryContentView: diaryContentView)
                }
            }
        }
    }
    
    func loadNotebooks() -> some View {
        ScrollView(.horizontal) {
            ForEach(notebookViewModel.notebooks) { i in
                
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
        
        .onAppear() {
            diaryContentView.notebooksViewModel = NotebooksViewModel()
        }
    }
}

#Preview {
    ContentView()
}
