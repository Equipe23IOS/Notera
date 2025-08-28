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
    @State var showPopupEmptyName: Bool = false
    @State var showPopupEmptySprite: Bool = false
    @State var selectedSprite: String = ""
    @ObservedObject var notebookViewModel: NotebooksViewModel
    var bColor: Color = Color("BackgroundColor")
    var txtColor: Color = Color("TextColor")
    var shapeColor: Color = Color("ButtonColor")
    var bTxtColor: Color = Color("ButtonTextColor")
    var sdwColor: Color = Color("ShadingColor")
    
    
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
                        .stroke(selectedSprite == i ? Color(shapeColor) : Color.clear, lineWidth: 4)
                        .padding(.all, 6)
                }
        }
    }
    
    var body:  some View {
        ZStack {
            Color(bColor)
                .ignoresSafeArea()
            
            VStack {
                Text("New Notebook")
                    .foregroundColor(txtColor)
                    .font(.custom("Leorio", size: 36))
                    .fontWeight(.bold)
                    .padding()
                
                TextField("Notebook Name", text: $notebookName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.custom("Leorio", size: 20))
                
                Text("Which notebook do you want?")
                    .foregroundColor(txtColor)
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
                        showPopupEmptyName.toggle()
                    } else if(selectedSprite == "") {
                        showPopupEmptySprite.toggle()
                    } else {
                        activateSheet.toggle()
                        notebookViewModel.createNotebook(notebookName, selectedSprite)
                    }
                }, label: {
                    Capsule()
                        .fill(Color(shapeColor))
                        .frame(width: 160, height: 40)
                        .overlay() {
                            Text("Create Notebook")
                                .padding()
                                .font(.custom("Leorio", size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(bTxtColor)
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
