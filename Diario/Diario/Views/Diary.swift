//
//  Diary.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/05/25.
//

import SwiftUI

struct Diary: View {
    @State private var diaryTitle: String = ""
    @State private var diaryEntry: String = ""
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
                    diaryContentView.createEntry(diaryTitle, diaryEntry)
                }
            }
        }
    }
}
