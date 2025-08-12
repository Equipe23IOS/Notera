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
    var todaysDate: Date = Calendar.current.date(from: DateComponents(month: Calendar.current.component(.month, from: Date()), day: Calendar.current.component(.day, from: Date())))!
    @AppStorage("startDate") var startDate: Date = Calendar.current.date(from: DateComponents(month: Calendar.current.component(.month, from: Date())))!
    @State var selectedDate: Date?
    @State var activateSheet: Bool = false
    @StateObject var humorTrackerViewModel: HumorTrackerViewModel = HumorTrackerViewModel()
    
    var body: some View {
        ZStack {
            Color.canvas
                .ignoresSafeArea()
            
            VStack {
                CalendarViewRepresentable(calendar: calendar, visibleDateRange: startDate...todaysDate, monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()), dataDependency: nil)
                    .verticalDayMargin(16)
                    .days() { day in
                        VStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.espresso, lineWidth: 2)
                                .frame(width: 40, height: 40)
                                .overlay() {
                                    Image(systemName: calendar.component(.day, from: todaysDate) >= day.day ? "plus" : "")
                                }
                          
                            Text(String(day.day))
                                .foregroundColor(.espresso)
                                .font(.custom("Leorio", size: 20))
                        }
                    }
                    .dayOfWeekHeaders() { month, weekdayIndex in
                        TextComponent(text: CalendarResources.weekdaySymbols[weekdayIndex], color: .espresso, size: 20)
                    }
                    .monthHeaders() { month in
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                if(todaysDate < startDate) {
                                    
                                }
                            }, label: {
                                Circle()
                                    .fill(.caramel)
                                    .frame(width: 40)
                                    .overlay() {
                                        Image(systemName: "chevron.left")
                                            .foregroundColor(todaysDate < startDate ? .toast : .canvas)
                                            
                                    }
                            })
                            .padding(.horizontal, -16)
                            .padding(.top, 16)
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.caramel)
                                .frame(width: 120, height: 40)
                                .overlay() {
                                    TextComponent(text: CalendarResources.monthSymbols[month.month - 1], color: .espresso, size: 20)
                                }
                                .padding()
                                .padding(.top, 16)
                            
                            Button(action: {
                                if(calendar.date(from: month.components)! > todaysDate) {
                                    
                                }
                            }, label: {
                                Circle()
                                    .fill(.caramel)
                                    .frame(width: 40)
                                    .overlay() {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(calendar.date(from: month.components)! > todaysDate ? .toast : .canvas)
                                    }
                            })
                            .padding(.leading, -16)
                            .padding(.trailing, 16)
                            .padding(.top, 16)
                        }
                    }
                    .onDaySelection() { day in
                        selectedDate = calendar.date(from: day.components)
                        activateSheet.toggle()
                    }
                    .backgroundColor(.linen)
                    .frame(height: 560)
                    .cornerRadius(20)
                    .padding()
                
                Spacer()
            }
            
            .sheet(isPresented: $activateSheet) {
                DayTrackingView(selectedDate: $selectedDate, activateSheet: $activateSheet, humorTrackerViewModel: humorTrackerViewModel)
            }
        }
    }
}

#Preview {
    HumorTrackerView()
}
