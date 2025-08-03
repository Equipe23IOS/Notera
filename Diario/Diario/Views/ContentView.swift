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
                        Image("NotebookSpr1")
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
                        
                        Text("Notera")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.toast)
                            .font(.custom("Georgia", size: 32))
                            .fontWeight(.bold)
                            .padding()
                        
                        Text("Get started with a new notebook\n It's quick and easy!")
                            .lineLimit(nil)
                            .foregroundColor(.bark)
                            .font(.custom("Georgia", size: 23))
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button(action: {
                            activateSheet = true
                        }, label: {
                            Capsule()
                                .fill(Color.toast)
                                .frame(width: 150, height: 50)
                                .overlay() {
                                    Text("New")
                                        .foregroundColor(.canvas)
                                        .fontWeight(.medium)
                                        .font(.custom("Georgia", size: 25))
                                }
                        })
                        
                        Spacer()
                    } else {
                        HStack {
                            Text("Notera")
                                .foregroundColor(.bark)
                                .font(.custom("Georgia", size: 30))
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                activateSheet = true
                            }, label: {
                                Capsule()
                                    .fill(Color.toast)
                                    .frame(width: 80, height: 30)
                                    .overlay() {
                                        Text("New")
                                            .foregroundColor(.canvas)
                                            .fontWeight(.medium)
                                            .font(.custom("Georgia", size: 15))
                                    }
                            })
                        }
                        .padding()
                        .background(.linen)
                        
                        loadNotebooks()
                        
                        Text("Recent entries")
                            .font(.custom("Georgia", size: 20))
                        
                        if(diaryContentViewModel.recentEntries.isEmpty) {
                            Text("You haven't written anything yet\n Fill it with something great!")
                                .padding()
                                .font(.custom("Georgia", size: 20))
                                .multilineTextAlignment(.center)
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
