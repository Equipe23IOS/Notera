//
//  DiaryCard.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/05/25.
//

import SwiftUI

struct DiaryCard: View {
    var title: String
    var notebookID: UUID?
    var pageID: UUID
    @ObservedObject var diaryContentViewModel: DiaryContentViewModel
    
    var body: some View {
        NavigationLink(destination: {
            if(false) {
                Text("Bacon")
            } else {
                // Aqui ele retorna um notebookModel, que pode ser optional
                let notebooks = diaryContentViewModel.notebooksViewModel.notebooks.filter { notebookModel in
                    return notebookModel.id == notebookID
                }.first
                
                // Aqui pega diretamente o objeto cujo id seja igual ao id passado previamente
                let recentEntriesPage = diaryContentViewModel.recentEntries.filter { diaryContent in
                    return diaryContent.id == pageID
                }.first
                
                
                let entriesNotebookPage = notebooks?.entries.filter({ diaryContent in
                    return diaryContent.id == pageID
                }).first
                
                Diary(
                    diaryTitle: notebooks != nil ? entriesNotebookPage!.title : recentEntriesPage!.title,
                    diaryEntry: notebooks != nil ? entriesNotebookPage!.entry : recentEntriesPage!.entry,
                    alreadyExists: true,
                    diaryContentViewModel: diaryContentViewModel,
                    pageID: pageID,
                    notebookID: notebookID
                )
            }
        }, label: {
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .overlay(
                        Text(title)
                            .foregroundColor(.black)
                    )
                
                Button(action: {
                    diaryContentViewModel.deleteEntryFromNotebook(pageID, notebookID)
                    diaryContentViewModel.deleteEntryFromRecentEntries(pageID)
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(.toast)
                })
            }
        })
        .padding(.horizontal, 10)
        .padding(.vertical, 1)
    }
}
