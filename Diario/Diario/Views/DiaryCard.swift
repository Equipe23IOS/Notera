//
//  DiaryCard.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/05/25.
//

import SwiftUI

struct DiaryCard: View {
    var title: String
    @State var index: Int?
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
            if(pageIndex == nil || index == nil) {
                EmptyView()
            } else {
                Diary(
                    diaryTitle: notebookIndex != nil && pageIndex != nil ? diaryContentViewModel.notebooksViewModel.notebooks[notebookIndex!].entries[diaryContentViewModel.wasDeleted ? index! - 1 : index!].title : diaryContentViewModel.recentEntries[pageIndex!].title,
                    diaryEntry: notebookIndex != nil && pageIndex != nil ? diaryContentViewModel.notebooksViewModel.notebooks[notebookIndex!].entries[diaryContentViewModel.wasDeleted ? index! - 1 : index!].entry : diaryContentViewModel.recentEntries[pageIndex!].entry,
                    alreadyExists: true,
                    indexOfPage: index!,
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
                    pageIndex = nil
                    index = nil
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
