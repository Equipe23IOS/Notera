//
//  DashboardView.swift
//  Diario
//
//  Created by iredefbmac_36 on 18/08/25.
//

import SwiftUI
import Charts

struct DashboardView: View {
    var data: [(name: String, amount: Int)] {
        humorTrackerViewModel.getInfo()
    }
    
    @ObservedObject var humorTrackerViewModel: HumorTrackerViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.linen)
                .frame(width: 400, height: 440)
            
            VStack {
                Chart(data, id: \.name) { name, amount in
                    SectorMark(
                        angle: .value("Amount", amount),
                        innerRadius: .ratio(0.5),
                        angularInset: 2
                    )
                    .foregroundStyle(by: .value("Categoria", name))
                    .cornerRadius(5)
                }
                .frame(width: 300, height: 300)
                .chartForegroundStyleScale([
                    "Very Sad": Color(red: 30/255, green: 58/255, blue: 95/255),
                    "Sad": Color(red: 59/255, green: 130/255, blue: 181/255),
                    "Neutral": Color(red: 92/255, green: 92/255, blue: 92/255),
                    "Happy": Color(red: 230/255, green: 138/255, blue: 46/255),
                    "Very Happy": Color(red: 2255/255, green: 210/255, blue: 63/255)
                ])
                
                
                HStack {
                    ForEach(CalendarResources.emojis.indices, id: \.self) { i in
                        VStack {
                            Image(CalendarResources.emojis[i])
                                .padding(.all, 4)
                            
                            TextComponent(text: String(data[i].amount), size: 24)
                        }
                    }
                }
            }
        }
        
        
    }
}
