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
    @ObservedObject var diaryContentViewModel: DiaryContentViewModel
    var pageID: UUID?
    var notebookID: UUID?
    
    var body: some View {
        VStack {
            TextField("Title", text: $diaryTitle)
                .font(.title)
            
            TextField("Write your ideas", text: $diaryEntry)
            
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                //TO DO mudar toda essa logica pra ViewModel no polimento do codigo mais a frente
                Button("Save") {
                    if(alreadyExists) {
                        if(notebookID == nil) {
                            for i in diaryContentViewModel.notebooksViewModel.notebooks {
                                for j in i.entries {
                                    if(j.id == pageID!) {
                                        print(j.id)
                                        diaryContentViewModel.updateDiaryPage(diaryTitle, diaryEntry, pageID!, i.id)
                                        break
                                    }
                                }
                            }
                            diaryContentViewModel.updateRecentEntries(diaryTitle, diaryEntry, pageID)
                        } else {
                            diaryContentViewModel.updateDiaryPage(diaryTitle, diaryEntry, pageID!, notebookID!)
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
                }
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
}
