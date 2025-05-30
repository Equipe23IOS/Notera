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
    @ObservedObject var diaryContentView: DiaryContentView
    
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
                        diaryContentView.updateDiaryPage(diaryTitle, diaryEntry, indexOfPage: indexOfPage)
                    } else {
                        diaryContentView.createEntry(diaryTitle, diaryEntry)
                    }
                }
            }
        }
    }
}
