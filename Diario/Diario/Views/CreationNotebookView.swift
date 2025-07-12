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
    @State var showPopup: Bool = false
    @ObservedObject var notebookViewModel: NotebooksViewModel
    
    var body:  some View {
        ZStack{
            Color(.linen)
            VStack{
                Text("New Notebook")
                    .foregroundColor(.espresso)
                    .font(.custom("Georgia", size: 32))
                    .fontWeight(.bold)
                    .padding()
                
                TextField("Notebook Name", text: $notebookName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                
                Button(action: {
                    if(notebookName == "") {
                        showPopup.toggle()
                    } else {
                        activateSheet.toggle()
                        notebookViewModel.createNotebook(notebookName)
                    }
                }) {
                    Text("Create Notebook")
                        .font(.custom("Georgia", size: 22))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.toast)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .alert("Erro", isPresented: $showPopup) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("O nome do notebook não pode estar vazio.")
                }
                .padding()
                
                Spacer()
                
            }
            .padding()
        }
    }
}
