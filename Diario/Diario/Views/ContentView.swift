//
//  ContentView.swift
//  Diario
//
//  Created by iredefbmac_36 on 05/05/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var diaryContentView = DiaryContentView()
    
    func loadDiaryCards() -> some View {
        ScrollView {
            VStack {
                ForEach(diaryContentView.entries.indices, id: \.self) { i in
                    return DiaryCard(title: diaryContentView.entries[i].title)
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Entries")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        Diary(diaryContentView: diaryContentView)
                    }, label: {
                        Text("New")
                    })
                }
                .padding()
                
                loadDiaryCards()
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
