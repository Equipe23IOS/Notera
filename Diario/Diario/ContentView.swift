//
//  ContentView.swift
//  Diario
//
//  Created by iredefbmac_36 on 05/05/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Entrys")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        Diary()
                    }, label: {
                        Text("New")
                    })
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct Diary: View {
    @State private var diaryTitle: String = ""
    @State private var diaryEntry: String = ""
    
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
                    print("Salvar: \(diaryTitle) - \(diaryEntry)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
