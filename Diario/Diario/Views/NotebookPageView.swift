//
//  NotebookPageView.swift
//  Diario
//
//  Created by iredefbmac_36 on 11/06/25.
//

import SwiftUI

struct NotebookPageView: View {
    @ObservedObject var diaryContentViewModel: DiaryContentViewModel
    @ObservedObject var notebookViewModel: NotebooksViewModel
    var notebookID: UUID
    
    var body: some View {
        NavigationStack {
            VStack() {
                Text("Entries")
                    .font(.largeTitle)
                    .bold()
                
                ScrollView {
                    VStack {
                        ForEach(notebookViewModel.notebooks) { i in
                            if(i.id == notebookID) {
                                ForEach(i.entries.indices, id: \.self) { j in
                                    let s = i.entries
                                    return DiaryCard(title: s[j].title, notebookID: i.id, pageID: s[j].id ,diaryContentViewModel: diaryContentViewModel)
                                }
                            }
                        }
                    }

                    Spacer()
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.toast)
                                
                                Text("Back")
                                    .foregroundColor(.toast)
                                    .font(.custom("Leorio", size: 20))
                            }
                        })
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: {
                            Diary(diaryContentViewModel: diaryContentViewModel, notebookID: notebookID)
                        }, label: {
                            Text("Write")
                                .foregroundColor(.toast)
                                .font(.custom("Leorio", size: 20))
                            
                            Image(systemName: "pencil.and.scribble")
                                .foregroundColor(.toast)
                            
                        })
                    }
                }
                .toolbarBackground(.linen, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        }
    }
}
