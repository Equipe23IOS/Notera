//
//  Diary.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/05/25.
//

import SwiftUI

struct Diary: View {
    @State var diaryTitle: String = ""
    @State var diaryEntry: String = ""
    @State var alreadyExists: Bool = false
    @State var indexOfPage: Int = 0
    @State private var emptyNotebookPopup: Bool = false
    @State private var emptyEntryPopup: Bool = false
    @State var isEditing: Bool = false
    @ObservedObject var diaryContentViewModel: DiaryContentViewModel
    @Environment(\.dismiss) var dismiss
    var pageID: UUID?
    var notebookID: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $diaryTitle)
                    .font(.title)
                
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal, 30)
                    .background(Color.gray)
                
                TextEditor(text: $diaryEntry)
                    .scrollContentBackground(.hidden)
                    .background(.canvas)
                    .frame(maxHeight: .infinity)
                    .overlay(alignment: .topLeading) {
                        if diaryEntry.isEmpty && !isEditing {
                            Text("Write your ideas")
                                .foregroundColor(.gray)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    isEditing = true
                                }
                            
                            Spacer()
                        }
                    }
                    .onTapGesture {
                        isEditing = true
                    }
                
                Spacer()
            }
            .padding()
            .background(.canvas)
            .cornerRadius(30)
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
                        }
                    })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if(alreadyExists) {
                            if(notebookID == nil) {
                                diaryContentViewModel.updateNotebook(diaryTitle, diaryEntry, pageID!, nil)
                                diaryContentViewModel.updateRecentEntries(diaryTitle, diaryEntry, pageID)
                            } else {
                                diaryContentViewModel.updateNotebook(diaryTitle, diaryEntry, pageID!, notebookID!)
                                diaryContentViewModel.updateRecentEntries(diaryTitle, diaryEntry, pageID)
                            }
                        } else {
                            if(diaryTitle == "") {
                                emptyNotebookPopup.toggle()
                            } else if(diaryEntry == "") {
                                emptyEntryPopup.toggle()
                            } else {
                                diaryContentViewModel.createEntry(diaryTitle, diaryEntry, notebookID)
                            }
                        }
                    }, label: {
                        Capsule()
                            .fill(Color.toast)
                            .frame(width: 80, height: 30)
                            .overlay() {
                                Text("Save")
                                    .foregroundColor(.linen)
                                    .fontWeight(.medium)
                            }
                    })
                    
                    .alert("Error", isPresented: $emptyNotebookPopup) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("The title can’t be empty.")
                    }
                    
                    .alert("Alert", isPresented: $emptyEntryPopup) {
                        Button("Proceed") {
                            diaryContentViewModel.createEntry(diaryTitle, diaryEntry, notebookID)
                        }
                        Button("Go back", role: .cancel) { }
                    } message: {
                        Text("The diary entry is empty. Do you still want to proceed?")
                    }
                }
            }
        }
        .padding()
        .background(.linen)
        .navigationTitle(diaryTitle)
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, minHeight: 200)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.canvas, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}
