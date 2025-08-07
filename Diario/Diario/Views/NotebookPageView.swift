//
//  NotebookPageView.swift
//  Diario
//
//  Created by iredefbmac_36 on 11/06/25.
//

import SwiftUI

struct NotebookPageView: View {
    @State var notebookModel: NotebookModel
    @ObservedObject var diaryContentViewModel: DiaryContentViewModel
    @ObservedObject var notebookViewModel: NotebooksViewModel
    @Environment(\.dismiss) var dismiss
    var notebookID: UUID
    
    var body: some View {
        ZStack {
            Color.canvas
                .ignoresSafeArea()
    
            NavigationStack {
                HStack() {
                    ScrollView {
                        VStack {
                            ForEach(notebookModel.entries) { i in
                                DiaryCard(title: i.title, notebookID: i.id, pageID: i.id , diaryContentViewModel: diaryContentViewModel)
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
                    
                    ToolbarItem(placement: .principal) {
                        Text(notebookModel.name)
                            .foregroundColor(.espresso)
                            .font(.custom("Leorio", size: 28))
                            .fontWeight(.bold)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: {
                            Diary(diaryContentViewModel: diaryContentViewModel, notebookID: notebookID)
                        }, label: {
                            Text("Write")
                                .foregroundColor(.toast)
                                .font(.custom("Leorio", size: 20))
                        })
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbarBackground(.linen, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        }
    }
}
