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
    
    func positioninArray(id: UUID?) -> Int? {
        return diaryContentViewModel.notebooksViewModel.notebooks.firstIndex { i in
            i.id == id
        }
    }
    
    var body: some View {
        let notebookIndex = positioninArray(id: notebookID)
        
        var pageIndex = diaryContentViewModel.recentEntries.firstIndex { i in
            i.id == pageID
        }
        
        NavigationLink(destination: {
            if(false) {
                Text("Bacon")
            } else {
                let notebooks = diaryContentViewModel.notebooksViewModel.notebooks.filter { notebookModel in
                    return notebookModel.id == notebookID
                }.first
                
                let notebookRecentEntries = diaryContentViewModel.recentEntries.filter { diaryContent in
                    return diaryContent.id == pageID
                }.first
                
                
                let entriesNotebookPage = notebooks?.entries.filter({ diaryContent in
                    return diaryContent.id == pageID
                }).first
                
                let entries = entriesNotebookPage ?? notebookRecentEntries
                
                if let notebooks = notebooks, let entries = entries {
                    Diary(
                        diaryTitle: entries.title,
                        diaryEntry: entries.entry,
                        alreadyExists: true,
                        diaryContentViewModel: diaryContentViewModel,
                        pageID: pageID,
                        notebookID: notebookID
                    )
                }
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
                    pageIndex = nil
                    diaryContentViewModel.returnDelete()
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
