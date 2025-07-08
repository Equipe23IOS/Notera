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
    @ObservedObject var diaryContentViewModel: DiaryContentViewModel
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
                Button("Save") {
                    if alreadyExists {
                        diaryContentViewModel.updateDiaryPage(diaryTitle, diaryEntry, indexOfPage, notebookID!)
                    } else {
                        diaryContentViewModel.createEntry(diaryTitle, diaryEntry, notebookID)
                    }
                }
            }
        }
    }
}
