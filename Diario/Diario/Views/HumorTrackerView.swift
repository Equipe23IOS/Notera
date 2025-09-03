//
//  HumorTrackerView.swift
//  Diario
//
//  Created by iredefbmac_36 on 02/08/25.
//

import SwiftUI
import HorizonCalendar

struct HumorTrackerView: View {
    @AppStorage("startDate") var startDate: Date = Calendar.current.date(from: DateComponents(month: Calendar.current.component(.month, from: Date())))!
    @StateObject var humorTrackerViewModel: HumorTrackerViewModel = HumorTrackerViewModel(trackedDays: [])
    @State var selectedDate: Date?
    @State var visibleDate: Date = Date()
    @State var activateSheet: Bool = false
    @State var showPopup: Bool = false
    
    let calendar: Calendar = Calendar.current
    var startDateComponents: DateComponents {
        return calendar.dateComponents([.year, .month, .day], from: startDate)
    }
    var visibleDateComponents: DateComponents {
        return calendar.dateComponents([.year, .month, .day], from: visibleDate)
    }
    
    func goBackAMonth() {
        guard let newMonth = Calendar.current.date(byAdding: .month, value: -1, to: visibleDate) else {
            return
        }
        visibleDate = newMonth
    }
    
    func goForwardOneMonth() {
        guard let newMonth = Calendar.current.date(byAdding: .month, value: 1, to: visibleDate) else {
            return
        }
        visibleDate = newMonth
    }
    
    
    var body: some View {
        ZStack {
            Colors.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    TitleComponent(title: "Calendar", weight: .bold)
                    
                    CalendarViewRepresentable(calendar: calendar, visibleDateRange: visibleDate...visibleDate, monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()), dataDependency: nil)
                        .verticalDayMargin(16)
                        .days() { day in
                            VStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Colors.textColor, lineWidth: 2)
                                    .frame(width: 40, height: 40)
                                    .overlay() {
                                        if(calendar.date(from: day.components) == humorTrackerViewModel.trackedDays.filter({ $0.day == calendar.date(from: day.components)} ).first?.day) {
                                            Image(humorTrackerViewModel.trackedDays.filter({ $0.day == calendar.date(from: day.components)} ).first!.emojiSprite)
                                                .resizable()
                                                .frame(width: 38, height: 38)
                                        } else {
                                            Image(systemName: visibleDateComponents.day! >= day.day ? "plus" : "nothing")
                                        }
                                    }
                              
                                TextComponent(text: String(day.day), size: 20)
                            }
                        }
                        .dayOfWeekHeaders() { month, weekdayIndex in
                            TextComponent(text: CalendarResources.weekdaySymbols[weekdayIndex], size: 20)
                        }
                        .monthHeaders() { month in
                            HStack {
                                Spacer()
                                
                                ButtonComponent(text: "", shapeColor: Colors.calendarButtons, size: 0, width: 40, height: 40, shape: Circle(), action: {
                                    if(visibleDateComponents.month != startDateComponents.month) {
                                        goBackAMonth()
                                    }
                                }, overlay: { AnyView(
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(visibleDateComponents.month != startDateComponents.month ? .toast : .canvas)
                                )})
                                .padding(.horizontal, -16)
                                .padding(.top, 16)
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Colors.calendarButtons)
                                    .frame(width: 120, height: 40)
                                    .overlay() {
                                        TextComponent(text: CalendarResources.monthSymbols[month.month - 1], size: 20)
                                    }
                                    .padding()
                                    .padding(.top, 16)
                                
                                ButtonComponent(text: "", shapeColor: Colors.calendarButtons, size: 0, width: 40, height: 40, shape: Circle(), action: {
                                    if(visibleDateComponents.month! > startDateComponents.month!) {
                                        goForwardOneMonth()
                                    }
                                }, overlay: { AnyView(
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(visibleDateComponents.month != startDateComponents.month ? .toast : .canvas)
                                )})
                                .padding(.leading, -16)
                                .padding(.trailing, 16)
                                .padding(.top, 16)
                            }
                        }
                        .onDaySelection() { day in
                            if(visibleDateComponents.day! >= day.day) {
                                selectedDate = calendar.date(from: day.components)
                                activateSheet.toggle()
                            } else {
                                showPopup.toggle()
                            }
                        }
                        .backgroundColor(UIColor(Colors.calendarBackground))
                        .frame(height: 640)
                        .cornerRadius(20)
                        .padding()
                    
                        .alert("Error", isPresented: $showPopup) {
                            Button("OK", role: .cancel) { }
                        } message: {
                            Text("This day will come, don't worry :)")
                        }
                    
                    TitleComponent(title: "Dashboard", weight: .bold)
                    
                    DashboardView(humorTrackerViewModel: humorTrackerViewModel)
                    
                    Spacer()
                }
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
