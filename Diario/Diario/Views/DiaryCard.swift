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
    var bColor: Color = Color("BackgroundColor")
    var txtColor: Color = Color("TextColor")
    var shapeColor: Color = Color("ButtonColor")
    var sdwColor: Color = Color("ShadingColor")
    @ObservedObject var diaryContentViewModel: DiaryContentViewModel
    
    var body: some View {
        NavigationLink(destination: {
            // Aqui ele retorna um notebookModel, que pode ser optional
            let notebooks = diaryContentViewModel.notebooksViewModel.notebooks.filter { notebookModel in
                return notebookModel.id == notebookID
            }.first
            
            // Aqui pega diretamente o objeto cujo id seja igual ao id passado previamente
            let recentEntriesPage = diaryContentViewModel.recentEntries.filter { diaryContent in
                return diaryContent.id == pageID
            }.first
            
            // Aqui ele retorna exatamente a entrada que tem que aberta
            let entriesNotebookPage = notebooks?.entries.filter({ diaryContent in
                return diaryContent.id == pageID
            }).first
            
            // Faz uma checagem se entrou pelo notebook, se sim roda o codigo
            if let entriesNotebookPage = entriesNotebookPage {
                Diary(
                    diaryTitle: entriesNotebookPage.title,
                    diaryEntry: entriesNotebookPage.entry,
                    alreadyExists: true,
                    diaryContentViewModel: diaryContentViewModel,
                    pageID: pageID,
                    notebookID: notebookID
                )
            } else {
                // Se entrou pela tela inical, verifica se a entrada existe
                if(recentEntriesPage != nil) {
                    Diary(
                        diaryTitle: recentEntriesPage!.title,
                        diaryEntry: recentEntriesPage!.entry,
                        alreadyExists: true,
                        diaryContentViewModel: diaryContentViewModel,
                        pageID: pageID,
                        notebookID: notebookID
                    )
                } else {
                    Text("bacon")
                }
            }
            
        }, label: {
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(bColor))
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48)
                    .shadow(color: sdwColor, radius: 5, y: 8)
                    .overlay () {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(shapeColor), lineWidth: 2)
                    }
                    .overlay() {
                        HStack {
                            Text(title)
                                .foregroundColor(txtColor)
                                .font(.custom("Leorio", size: 16))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                            
                            Button(action: {
                                diaryContentViewModel.deleteEntryFromNotebook(pageID, notebookID)
                                diaryContentViewModel.deleteEntryFromRecentEntries(pageID)
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(shapeColor)
                            })
                        }
                        .padding()
                        .padding(.horizontal, 8)
                    }
            }
        })
        .padding(.horizontal, 10)
        .padding(.vertical, 1)
    }
}
