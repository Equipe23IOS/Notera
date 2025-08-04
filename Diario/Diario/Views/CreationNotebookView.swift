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
                    .font(.custom("Leorio", size: 36))
                    .fontWeight(.bold)
                    .padding()
                
                TextField("Notebook Name", text: $notebookName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.custom("Leorio", size: 12))
                
                ScrollView(.horizontal) {
                    HStack {
                        loadSprites()
                    }
                }
                
                Button(action: {
                    if(notebookName == "") {
                        showPopup.toggle()
                    } else {
                        activateSheet.toggle()
                        notebookViewModel.createNotebook(notebookName)
                    }
                }, label: {
                    Capsule()
                        .fill(Color.toast)
                        .frame(width: 160, height: 40)
                        .overlay() {
                            Text("Create Notebook")
                                .padding()
                                .font(.custom("Leorio", size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.linen)
                        }
                })
                .alert("Error", isPresented: $showPopup) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Notebook name can’t be empty.")
                }
                .padding()
                
                Spacer()
                
            }
            .padding()
        }
    }
}
