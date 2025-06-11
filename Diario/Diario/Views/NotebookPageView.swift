//
//  NotebookPageView.swift
//  Diario
//
//  Created by iredefbmac_36 on 11/06/25.
//

import SwiftUI

struct NotebookPageView: View {
    @ObservedObject var diaryContentViewModel: DiaryContentViewModel
    @ObservedObject var notebookViewModel: NotebooksViewModel
    
    var body: some View {
        NavigationStack {
            VStack() {
                Text("Entries")
                    .font(.largeTitle)
                    .bold()
                
                ScrollView {
                    VStack {
                        ForEach(diaryContentViewModel.entries.indices, id: \.self) { i in
                            return DiaryCard(title: $diaryContentViewModel.entries[i].title, index: i,diaryContentViewModel: diaryContentViewModel)
                        }
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: {
                        Diary(diaryContentViewModel: diaryContentViewModel)
                    }, label: {
                        Text("New")
                    })
                }
            }
        }
    }
}
