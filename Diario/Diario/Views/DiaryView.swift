//
//  Diary.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/05/25.
//

import SwiftUI

struct Diary: View {
    @ObservedObject var diaryContentViewModel: DiaryContentViewModel
    @Environment(\.dismiss) var dismiss
    @State var diaryTitle: String = ""
    @State var diaryEntry: String = ""
    @State var alreadyExists: Bool = false
    @State private var emptyNotebookPopup: Bool = false
    @State private var emptyEntryPopup: Bool = false
    @State var isEditing: Bool = false
    var pageID: UUID?
    var notebookID: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                TextFieldComponent(text: "Title", size: 24, hideStroke: true, textFieldVariable: $diaryTitle)
                
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal, 30)
                    .background(Color.gray)
                
                TextEditor(text: $diaryEntry)
                    .foregroundColor(Colors.textColor)
                    .font(.custom("Leorio", size: 20))
                    .scrollContentBackground(.hidden)
                    .background(Colors.backgroundColor)
                    .frame(maxHeight: .infinity)
                    .overlay(alignment: .topLeading) {
                        if diaryEntry.isEmpty && !isEditing {
                            Text("Write your ideas")
                                .font(.custom("Leorio", size: 16))
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
            .background(Colors.backgroundColor)
            .cornerRadius(30)
            .shadow(color: Colors.shadingColor, radius: 12, y: 4)
        }
        .padding()
        .background(Colors.backgroundColor)
        .navigationTitle(diaryTitle)
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, minHeight: 200)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(Colors.toolbarColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Colors.buttonColor)
                        
                        Text("Back")
                            .foregroundColor(Colors.buttonColor)
                            .font(.custom("Leorio", size: 20))
                    }
                })
            }
            
            
            ToolbarItem(placement: .principal) {
                TitleComponent(title: diaryTitle, weight: .bold, size: 28)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                ButtonComponent(text: "Save", size: 20, width: 80, height: 32, shape: Capsule(), action: {
                    if(alreadyExists) {
                        if(notebookID == nil) {
                            diaryContentViewModel.updateNotebook(diaryTitle, diaryEntry, pageID!, nil)
                            diaryContentViewModel.updateRecentEntries(diaryTitle, diaryEntry, pageID)
                            dismiss()
                        } else {
                            diaryContentViewModel.updateNotebook(diaryTitle, diaryEntry, pageID!, notebookID!)
                            diaryContentViewModel.updateRecentEntries(diaryTitle, diaryEntry, pageID)
                            dismiss()
                        }
                    } else {
                        if(diaryTitle.trimmingCharacters(in: .whitespaces) == "") {
                            emptyNotebookPopup.toggle()
                        } else if(diaryEntry.trimmingCharacters(in: .whitespaces) == "") {
                            emptyEntryPopup.toggle()
                        } else {
                            diaryContentViewModel.createEntry(diaryTitle, diaryEntry, notebookID)
                            dismiss()
                        }
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
                        dismiss()
                    }
                    Button("Go back", role: .cancel) { }
                } message: {
                    Text("The diary entry is empty. Do you still want to proceed?")
                }
            }
        }
    }
}
