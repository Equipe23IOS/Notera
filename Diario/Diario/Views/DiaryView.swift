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
    @State private var emptyNotebookPopup: Bool = false
    @State private var emptyEntryPopup: Bool = false
    @State var isEditing: Bool = false
    @ObservedObject var diaryContentViewModel: DiaryContentViewModel
    @Environment(\.dismiss) var dismiss
    var bColor: Color = Color("BackgroundColor")
    var txtColor: Color = Color("TextColor")
    var shapeColor: Color = Color("ButtonColor")
    var bTxtColor: Color = Color("ButtonTextColor")
    var tColor: Color = Color("ToolbarColor")
    var sdwColor: Color = Color("ShadingColor")
    var pageID: UUID?
    var notebookID: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $diaryTitle)
                    .foregroundColor(txtColor)
                    .font(.custom("Leorio", size: 24))
                    .fontWeight(.bold)
                
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal, 30)
                    .background(Color.gray)
                
                TextEditor(text: $diaryEntry)
                    .foregroundColor(txtColor)
                    .font(.custom("Leorio", size: 20))
                    .scrollContentBackground(.hidden)
                    .background(bColor)
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
            .background(bColor)
            .cornerRadius(30)
            .shadow(color: sdwColor, radius: 12, y: 4)
        }
        .padding()
        .background(bColor)
        .navigationTitle(diaryTitle)
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, minHeight: 200)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(tColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(shapeColor)
                        
                        Text("Back")
                            .foregroundColor(shapeColor)
                            .font(.custom("Leorio", size: 20))
                    }
                })
            }
            
            
            ToolbarItem(placement: .principal) {
                Text(diaryTitle)
                    .foregroundColor(txtColor)
                    .font(.custom("Leorio", size: 28))
                    .fontWeight(.bold)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
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
                        if(diaryTitle == "") {
                            emptyNotebookPopup.toggle()
                        } else if(diaryEntry == "") {
                            emptyEntryPopup.toggle()
                        } else {
                            diaryContentViewModel.createEntry(diaryTitle, diaryEntry, notebookID)
                            dismiss()
                        }
                    }
                }, label: {
                    Capsule()
                        .fill(Color(shapeColor))
                        .frame(width: 80, height: 30)
                        .overlay() {
                            Text("Save")
                                .foregroundColor(bTxtColor)
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
