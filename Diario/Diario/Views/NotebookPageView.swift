//
//  NotebookPageView.swift
//  Diario
//
//  Created by iredefbmac_36 on 11/06/25.
//

import SwiftUI

struct NotebookPageView: View {
    @State var notebookModel: NotebookModel
    @ObservedObject var diaryContentViewModel: DiaryContentViewModel
    @ObservedObject var notebookViewModel: NotebooksViewModel
    @Environment(\.dismiss) var dismiss
    var notebookID: UUID
    var bColor: Color = Color("BackgroundColor")
    var txtColor: Color = Color("TextColor")
    var shapeColor: Color = Color("ButtonColor")
    var bTxtColor: Color = Color("ButtonTextColor")
    var tColor: Color = Color("ToolbarColor")
    
    var body: some View {
        ZStack {
            Color(bColor)
                .ignoresSafeArea()
    
            NavigationStack {
                HStack() {
                    ScrollView {
                        VStack {
                            ForEach(notebookModel.entries) { i in
                                DiaryCard(diaryContentViewModel: diaryContentViewModel, title: i.title, notebookID: i.id, pageID: i.id)
                            }
                        }
                    }

                    Spacer()
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(.hidden, for: .tabBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(shapeColor)
                                
                                Text("Back")
                                    .foregroundColor(shapeColor)
                                    .font(.custom("Leorio", size: 20))
                            }
                        })
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text(notebookModel.name)
                            .foregroundColor(txtColor)
                            .font(.custom("Leorio", size: 28))
                            .fontWeight(.bold)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: {
                            Diary(diaryContentViewModel: diaryContentViewModel, notebookID: notebookID)
                        }, label: {
                            Text("Write")
                                .foregroundColor(shapeColor)
                                .font(.custom("Leorio", size: 20))
                        })
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbarBackground(tColor, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        }
    }
}
