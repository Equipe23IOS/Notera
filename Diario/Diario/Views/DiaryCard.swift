//
//  DiaryCard.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/05/25.
//

import SwiftUI

struct DiaryCard: View {
    var title: String
    var index: Int
    @ObservedObject var diaryContentView: DiaryContentView
    
    
    var body: some View {
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
            .overlay(
                NavigationLink(destination:
                    Diary(
                        diaryTitle: diaryContentView.entries[index].title,
                        diaryEntry: diaryContentView.entries[index].entry,
                        alreadyExists: true,
                        indexOfPage: index,
                        diaryContentView: diaryContentView
                    ),
                    label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.red)
                            .blendMode(.destinationOver)
                })
            )
            .padding(.horizontal, 10)
            .padding(.vertical, 1)
    }
}
