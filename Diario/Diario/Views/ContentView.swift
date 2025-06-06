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
    @State var activateSheet: Bool = false
    
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
                    
                    Button(action: {
                        activateSheet = true
                    }) {
                        Text("New")
                    }
                }
                .padding()
                
                loadDiaryCards()
            
                Spacer()
            }
        }
        
        .onAppear() {
            diaryContentView.notebooksViewModel = NotebooksViewModel()
        }
        
        .sheet(isPresented: $activateSheet) {
            CreationNotebookView(activateSheet: $activateSheet)
        }
    }
}

#Preview {
    ContentView()
}
