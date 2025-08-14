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
                    return DiaryCard(title: diaryContentViewModel.recentEntries[i].title, pageID: diaryContentViewModel.recentEntries[i].id, diaryContentViewModel: diaryContentViewModel)
                }
            }
        }
    }
    
    func loadNotebooks() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 25) {
                ForEach(notebookViewModel.notebooks) { i in
                    NavigationLink(destination: NotebookPageView(notebookModel: i, diaryContentViewModel: diaryContentViewModel, notebookViewModel: notebookViewModel, notebookID: i.id),
                                   label: {
                        Image(i.sprite)
                            .overlay() {
                                Button(action: {
                                    diaryContentViewModel.evaluateDeletedNotebook(i.id)
                                    notebookViewModel.deleteNotebook(i.id)
                                }, label: {
                                    Image(systemName: "trash")
                                        .frame(width: 25, height: 25, alignment: .topTrailing)
                                })
                            }
                    })
                }
            }
            .padding()
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.canvas).edgesIgnoringSafeArea(.all)
                VStack {
                    if(notebookViewModel.notebooks.isEmpty) {
                        Spacer()
                        
                        TitleComponent(title: "Notera", color: .caramel, weight: .bold)
                        
                        TextComponent(text: "Get started with a new notebook\n It's quick and easy!", color: .caramel)
                        
                        ButtonComponent(text: "New", color: .toast, size: 24, width: 160, height: 40) {
                            activateSheet = true
                        }
                        
                        Spacer()
                    } else {
                        HStack {
                            TitleComponent(title: "Notera", color: .espresso, weight: .bold)
                            
                            Spacer()
                            
                            ButtonComponent(text: "New", color: .toast, size: 16, width: 80, height: 32) {
                                activateSheet = true
                            }
                        }
                        .padding()
                        .background(.linen)
                        
                        loadNotebooks()
                        
                        TitleComponent(title: "Recent entries", color: .espresso, weight: .bold, size: 20)
                            
                        if(diaryContentViewModel.recentEntries.isEmpty) {
                            TextComponent(text: "You haven't written anything yet\n Fill it with something great!", color: .espresso)
                                .padding()
                        } else {
                            loadDiaryCards()
                        }
                        
                        Spacer()
                    }
                }
            }
            
            .sheet(isPresented: $activateSheet) {
                CreationNotebookView(activateSheet: $activateSheet, notebookViewModel: notebookViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
