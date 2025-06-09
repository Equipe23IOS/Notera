//
//  ContentView.swift
//  Diario
//
//  Created by iredefbmac_36 on 05/05/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var diaryContentViewModel = DiaryContentViewModel()
    @StateObject var notebookViewModel = NotebooksViewModel()
    @State var activateSheet: Bool = false
    
    func loadDiaryCards() -> some View {
        ScrollView {
            VStack {
                ForEach(diaryContentViewModel.entries.indices, id: \.self) { i in
                    return DiaryCard(title: $diaryContentViewModel.entries[i].title, index: i,diaryContentViewModel: diaryContentViewModel)
                }
            }
        }
    }
    
    func loadNotebooks() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 25) {
                ForEach(notebookViewModel.notebooks) { i in
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.black)
                        .frame(minWidth: 120, maxHeight: 200)
                }
            }
            .padding()
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
                
                loadNotebooks()
                
                if(notebookViewModel.notebooks.isEmpty) {
                    Text("Create a new notebook and start writing right away!")
                } else {
                    Text("Recent entries")
                    loadDiaryCards()
                }
            
                Spacer()
            }
        }
        
        .onAppear() {
            diaryContentViewModel.notebooksViewModel = NotebooksViewModel()
        }
        
        .sheet(isPresented: $activateSheet) {
            CreationNotebookView(activateSheet: $activateSheet, notebookViewModel: notebookViewModel)
        }
    }
}

#Preview {
    ContentView()
}
