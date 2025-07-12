//
//  DiaryCard.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/05/25.
//

import SwiftUI

struct DiaryCard: View {
    var title: String
    let index: Int
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
        
        let pageIndex = diaryContentViewModel.recentEntries.firstIndex { i in
            i.id == pageID
        }
        
        NavigationLink(destination:
            Diary(
                diaryTitle: notebookIndex != nil && pageIndex != nil ? diaryContentViewModel.notebooksViewModel.notebooks[notebookIndex!].entries[index].title : diaryContentViewModel.recentEntries[pageIndex!].title,
                diaryEntry: notebookIndex != nil && pageIndex != nil ? diaryContentViewModel.notebooksViewModel.notebooks[notebookIndex!].entries[index].entry : diaryContentViewModel.recentEntries[pageIndex!].entry,
                alreadyExists: true,
                indexOfPage: index,
                diaryContentViewModel: diaryContentViewModel,
                pageID: pageID,
                notebookID: notebookID
            ),
            label: {
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
        })
        .padding(.horizontal, 10)
        .padding(.vertical, 1)
    }
}
