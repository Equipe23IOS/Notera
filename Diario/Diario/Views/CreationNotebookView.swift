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
    @State var selectedSprite: String = ""
    @ObservedObject var notebookViewModel: NotebooksViewModel
    
    
    func loadSprites() -> some View {
        ForEach(NotebookSprites.notebookSprites, id: \.self) { i in
            Image(i)
                .padding()
                .onTapGesture() {
                    selectedSprite = i
                    print(i)
                }
                .overlay() {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(selectedSprite == i ? Color.canvas : Color.clear, lineWidth: 4)
                        .padding(.all, 6)
                }
        }
    }
    
    var body:  some View {
        ZStack {
            Color(.linen)
            VStack {
                Text("New Notebook")
                    .foregroundColor(.espresso)
                    .font(.custom("Leorio", size: 36))
                    .fontWeight(.bold)
                    .padding()
                
                TextField("Notebook Name", text: $notebookName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.custom("Leorio", size: 20))
                
                Text("Which notebook do you want?")
                    .foregroundColor(.espresso)
                    .font(.custom("Leorio", size: 24))
                    .fontWeight(.bold)
                    .padding()
                
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
                        notebookViewModel.createNotebook(notebookName, selectedSprite)
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
