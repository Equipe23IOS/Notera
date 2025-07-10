//
//  ContentView.swift
//  Diario
//
//  Created by iredefbmac_36 on 05/05/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var notebookViewModel: NotebooksViewModel
    @StateObject private var diaryContentViewModel: DiaryContentViewModel
    @State var activateSheet: Bool = false
    
    init() {
        let notebooks = NotebooksViewModel()
        _notebookViewModel = StateObject(wrappedValue: notebooks)
        _diaryContentViewModel = StateObject(wrappedValue: DiaryContentViewModel(notebooksViewModel: notebooks))
    }
    
    func loadDiaryCards() -> some View {
        ScrollView {
            VStack {
                ForEach(diaryContentViewModel.recentEntries.indices, id: \.self) { i in
                    return DiaryCard(title: diaryContentViewModel.recentEntries[i].title, index: i, pageID: diaryContentViewModel.recentEntries[i].id, diaryContentViewModel: diaryContentViewModel)
                }
            }
        }
    }
    
    func loadNotebooks() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 25) {
                ForEach(notebookViewModel.notebooks) { i in
                    NavigationLink(destination: NotebookPageView(diaryContentViewModel: diaryContentViewModel, notebookViewModel: notebookViewModel, notebookID: i.id),
                                   label: {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.black)
                            .frame(minWidth: 120, maxHeight: 200)
                    })
                }
            }
            .padding()
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Notera")
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
                    Text("Create a new notebook\nstart writing right away!")
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
