//
//  DashboardView.swift
//  Diario
//
//  Created by iredefbmac_36 on 18/08/25.
//

import SwiftUI
import Charts

struct DashboardView: View {
    @ObservedObject var humorTrackerViewModel: HumorTrackerViewModel
    var data: [(name: String, amount: Int)] {
        humorTrackerViewModel.getInfo()
    }
    var dataIsEmpty: Bool {
        humorTrackerViewModel.checksForTrackedDays(data: data)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Colors.calendarBackground)
                .frame(width: dataIsEmpty ? 320 : 400, height: dataIsEmpty ? 320 : 440)
            
            VStack {
                if(dataIsEmpty) {
                    VStack(spacing: 24) {
                        Image(systemName: "chart.pie")
                            .font(.largeTitle)
                            .foregroundStyle(Colors.textColor)
                        
                        TextComponent(text: "There isn't any data available yet!")
                    }
                    .padding()
                } else {
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
                }
                
                HStack {
                    if(dataIsEmpty != true) {
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
}
