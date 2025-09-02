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
    @State var sideBarIsOpened: Bool = false
    @State var notebookToDelete: NotebookModel? = nil
    @Environment(\.dismiss) var dismiss
    
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
                            .onLongPressGesture {
                                notebookToDelete = i
                            }
                    })
                }
            }
            .padding()
        }
        .alert("Alert", isPresented: Binding(
                    get: { notebookToDelete != nil },
                    set: { if !$0 { notebookToDelete = nil } }
                )) {
                Button("Delete") {
                    if let toDelete = notebookToDelete {
                        print(toDelete.name)
                        diaryContentViewModel.evaluateDeletedNotebook(toDelete.id)
                        notebookViewModel.deleteNotebook(toDelete.id)
                        dismiss()
                    }
                }
                Button("Go back", role: .cancel) {
                    notebookToDelete = nil
                }
            } message: {
                if let toDelete = notebookToDelete {
                    Text("Are you sure you want to delete \(toDelete.name)?")
                } else {
                    Text("Error: no notebook selected")
                }
            }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if(notebookViewModel.notebooks.isEmpty) {
                        Spacer()
                        
                        TitleComponent(title: "Notera", weight: .bold)
                        
                        TextComponent(text: "Get started with a new notebook\n It's quick and easy!")
                        
                        ButtonComponent(text: "New", size: 24, width: 160, height: 40, shape: Capsule()) {
                            activateSheet = true
                        }
                        
                        Spacer()
                    } else {
                        HStack {
                            TitleComponent(title: "Notera",  weight: .bold)
                                .onTapGesture {
                                    sideBarIsOpened.toggle()
                                }
                            
                            Spacer()
                            
                            ButtonComponent(text: "New", size: 16, width: 80, height: 32, shape: Capsule()) {
                                activateSheet = true
                            }
                        }
                        .padding()
                        .background(Color("ToolbarColor"))
                        
                        loadNotebooks()
                        
                        TitleComponent(title: "Recent entries", weight: .bold, size: 20)
                            
                        if(diaryContentViewModel.recentEntries.isEmpty) {
                            TextComponent(text: "You haven't written anything yet\n Fill it with something great!")
                                .padding()
                        } else {
                            loadDiaryCards()
                        }
                        
                        Spacer()
                    }
                }
                
                SideBarMenuView(sidebarIsOpened: $sideBarIsOpened)

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
