//
//  DayTrackingView.swift
//  Diario
//
//  Created by iredefbmac_36 on 11/08/25.
//

import SwiftUI

struct DayTrackingView: View {
    @Binding var selectedDate: Date?
    @Binding var memo: String
    @State var selectedSprite: String
    @ObservedObject var humorTrackerViewModel: HumorTrackerViewModel
    
    var body: some View {
        ZStack {
            Color.canvas
                .ignoresSafeArea()
            
            VStack {
                TitleComponent(title: "How are you feeling?", color: .espresso, weight: .bold)
                
                //ForEach() {}
                
                TextField("Add a memo", text: $memo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.custom("Leorio", size: 20)).padding()
                
                Button(action: {
                    humorTrackerViewModel.createDay(selectedSprite, memo)
                }, label: {
                    Capsule()
                        .fill(Color.toast)
                        .frame(width: 160, height: 40)
                        .overlay() {
                            Text("Save")
                                .foregroundColor(.canvas)
                                .fontWeight(.medium)
                                .font(.custom("Leorio", size: 25))
                        }
                })
            }
        }
    }
}

#Preview {
    @Previewable @State var a: Date? = Date()
    @Previewable @State var b: String = ""
    DayTrackingView(selectedDate: $a, memo: $b, selectedSprite: "", humorTrackerViewModel: HumorTrackerViewModel())
}
