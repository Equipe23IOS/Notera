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
            ZStack {
                Color(.canvas).edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Button(action: {
                            activateSheet = true
                        }) {
                            Text("New")
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.espresso)
                                .font(.custom("Georgia", size: 23))
                                .fontWeight(.bold)
                                .padding(.leading, 290.0)
                        }
                    }
                    
                    Text("Notera")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(.espresso)
                        .font(.custom("Georgia", size: 32))
                        .fontWeight(.bold)
                        .padding(.top, 320.0)
                    
                    loadNotebooks()
                    
                    if(notebookViewModel.notebooks.isEmpty) {
                        Text("Create your new Notebook\n right away!")
                            .lineLimit(nil)
                            .foregroundColor(.bark)
                            .font(.custom("Georgia", size: 23))
                            .multilineTextAlignment(.center)
                        
                        Spacer(minLength: 320)
                        
                    } else {
                        Text("Recent entries")
                        loadDiaryCards()
                    }
                    
                    Spacer()
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
