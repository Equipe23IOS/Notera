//
//  HumorTrackerView.swift
//  Diario
//
//  Created by iredefbmac_36 on 02/08/25.
//

import SwiftUI
import HorizonCalendar

struct HumorTrackerView: View {
    let calendar: Calendar = Calendar.current
    var startDate: Date
    var todaysDate: Date
    @State var selectedDate: Date?
    
    init() {
        startDate = calendar.date(from: DateComponents(month: calendar.component(.month, from: Date())))!
        todaysDate = calendar.date(from: DateComponents(month: calendar.component(.month, from: Date()), day: calendar.component(.day, from: Date())))!
    }
    
    var body: some View {
        ZStack {
            Color.canvas
                .ignoresSafeArea()
            
            VStack {
                CalendarViewRepresentable(calendar: calendar, visibleDateRange: startDate...todaysDate, monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()), dataDependency: nil)
                    .days() { day in
                        Text(String(day.day))
                            .foregroundColor(.espresso)
                            .font(.custom("Leorio", size: 20))
                            .frame(width: 40, height: 40)
                            .overlay() {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.espresso, lineWidth: 2)
                            }
                    }
                    .dayOfWeekHeaders() { month, weekdayIndex in
                        Text(CalendarResources.weekdaySymbols[weekdayIndex])
                    }
                    .monthHeaders() { month in
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                
                            }, label: {
                                Circle()
                                    .fill(.caramel)
                                    .frame(width: 40)
                                    .overlay() {
                                        Image(systemName: "chevron.left")
                                        
                                            
                                    }
                            })
                            .padding(.horizontal, -16)
                            .padding(.top, 16)
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.caramel)
                                .frame(width: 120, height: 40)
                                .overlay() {
                                    Text(CalendarResources.monthSymbols[month.month - 1])
                                }
                                .padding()
                                .padding(.top, 16)
                            
                            Button(action: {
                                
                            }, label: {
                                Circle()
                                    .fill(.caramel)
                                    .frame(width: 40)
                                    .overlay() {
                                        Image(systemName: "chevron.right")
                                    }
                            })
                            .padding(.leading, -16)
                            .padding(.trailing, 16)
                            .padding(.top, 16)
                        }
                    }
                    .backgroundColor(.linen)
                    .frame(width: .infinity, height: 480)
                    .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    HumorTrackerView()
}
