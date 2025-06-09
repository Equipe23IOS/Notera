//
//  CreatingNotebookView.swift
//  Diario
//
//  Created by iredefbmac_36 on 02/06/25.
//

import SwiftUI

struct CreationNotebookView: View{
    @Binding var activateSheet: Bool
    @State var notebookName: String = ""
    @ObservedObject var notebookViewModel: NotebooksViewModel
    
    var body:  some View {
        VStack{
            Text("New Notebook")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            TextField("Notebook Name", text: $notebookName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            Button(action: {
                activateSheet.toggle()
                notebookViewModel.createNotebook(notebookName)
            }) {
                Text("Create Notebook")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            
            .padding()
            
            Spacer()
            
            }
        .padding()
    }
}
