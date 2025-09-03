//
//  CreatingNotebookView.swift
//  Diario
//
//  Created by iredefbmac_36 on 02/06/25.
//

import SwiftUI

struct CreationNotebookView: View{
    @ObservedObject var notebookViewModel: NotebooksViewModel
    @Binding var activateSheet: Bool
    @State var notebookName: String = ""
    @State var showPopupEmptyName: Bool = false
    @State var showPopupEmptySprite: Bool = false
    @State var selectedSprite: String = ""
    
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
                        .stroke(selectedSprite == i ? Colors.buttonColor : Color.clear, lineWidth: 4)
                        .padding(.all, 6)
                }
        }
    }
    
    var body:  some View {
        ZStack {
            Color(Colors.backgroundColor)
                .ignoresSafeArea()
            
            VStack {
                TitleComponent(title: "New Notebook", weight: .bold)
                    .padding()
                
                TextFieldComponent(text: "Notebook name", size: 20, textFieldVariable: $notebookName)
                    .padding()
                
                TextComponent(text: "Which notebook do you want?", size: 20)
                    .padding()
                
                ScrollView(.horizontal) {
                    HStack {
                        loadSprites()
                    }
                }
                
                ButtonComponent(text: "Create Notebook", size: 16, width: 160, height: 40, shape: Capsule(), action: {
                    if(notebookName == "") {
                        showPopupEmptyName.toggle()
                    } else if(selectedSprite == "") {
                        showPopupEmptySprite.toggle()
                    } else {
                        activateSheet.toggle()
                        notebookViewModel.createNotebook(notebookName, selectedSprite)
                    }
                })
                .alert("Error", isPresented: $showPopupEmptyName) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Notebook name can’t be empty.")
                }
                .padding()
                
                .alert("Error", isPresented: $showPopupEmptySprite) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("You didn’t choose a notebook.")
                }
                .padding()
                
                Spacer()
                
            }
            .padding()
        }
    }
}
