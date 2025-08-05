//
//  HumorTrackerView.swift
//  Diario
//
//  Created by iredefbmac_36 on 02/08/25.
//

import SwiftUI

struct HumorTrackerView: View {
    @State var todaysMonth: Date = Date()
    var daysOfEachMonth: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    
    func getDays() -> Int {
        let monthInt = Calendar.current.component(.month, from: todaysMonth)
        let data: Int = daysOfEachMonth[monthInt - 1]
        return data
    }
        
    func loadDays() -> some View {
        Grid(horizontalSpacing: 2, verticalSpacing: 2) {
            ForEach(0..<6) { row in
                GridRow {
                    ForEach(0..<7) { column in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.cyan)
                            .frame(width: 40, height: 40)
                            .overlay() {
                                Text(String(row) + String(column))
                            }
                    }
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.canvas
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 360, height: 400)
            
            VStack() {
                HStack() {
                    loadDays()
                }
            }
        }
    }
}

#Preview {
    HumorTrackerView()
}
