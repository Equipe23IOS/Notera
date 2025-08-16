//
//  DayTrackingView.swift
//  Diario
//
//  Created by iredefbmac_36 on 11/08/25.
//

import SwiftUI

struct DayTrackingView: View {
    @Binding var selectedDate: Date?
    @Binding var activateSheet: Bool
    @State var memo: String = ""
    @State var selectedSprite: String = ""
    @ObservedObject var humorTrackerViewModel: HumorTrackerViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.canvas
                .ignoresSafeArea()
            
            VStack {
                TitleComponent(title: "How are you feeling?", color: .espresso, weight: .bold)
                
                    HStack {
                        Spacer()
                        
                        ForEach(CalendarResources.emojis.indices, id: \.self) { i in
                            Image(CalendarResources.emojis[i])
                                .onTapGesture() {
                                    selectedSprite = CalendarResources.emojis[i]
                                }
                                .overlay() {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(selectedSprite == CalendarResources.emojis[i] ? Color.caramel: Color.clear, lineWidth: 4)
                                        .frame(width: 68, height: 68)
                                }
                                .padding(.all, 8)
                        }
                        
                        Spacer()
                    }
                    .padding()
               
                
                TextFieldComponent(text: "Add a memo", size: 20)
                    .padding()
                
                ButtonComponent(text: "Save", color: .toast, size: 25, width: 160, height: 40) {
                    humorTrackerViewModel.createDay(selectedDate!, selectedSprite, memo)
                    dismiss()
                }
            }
        }
    }
}
