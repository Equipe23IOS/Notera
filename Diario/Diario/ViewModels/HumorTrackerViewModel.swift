//
//  HumorTrackerViewModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 09/08/25.
//

import SwiftUI

class HumorTrackerViewModel: ObservableObject {
    let database = DataSource.shared
    @Published var trackedDays: [DayModel] = []
    
    init(trackedDays: [DayModel]) {
        self.trackedDays = database.fetchDays()
    }
    
    func createDay(_ day: Date, _ selectedSprite: String, _ memo: String) {
        let day = DayModel(day: day, emojiSprite: selectedSprite, memo: memo)
        database.appendDay(day: day)
        trackedDays.append(day)
        print(day.memo)
    }
    
    func deleteDay(_ day: DayModel) {
        database.deleteDay(day: day)
        trackedDays.removeAll(where: { $0.id == day.id })
    }
    
    func updateDay(_ day: DayModel, _ selectedSprite: String, _ memo: String) {
        guard let index = trackedDays.firstIndex(where: { $0.id == day.id }) else {
            return
        }
        
        trackedDays[index].memo = memo
        trackedDays[index].emojiSprite = selectedSprite
        trackedDays = trackedDays
        database.updateDay(day: trackedDays[index], updatedDay: day)
    }
    
    func getDay(_ day: Date) -> DayModel? {
        let componentDay = Calendar.current.dateComponents([.year, .month, .day], from: day)
        guard let componentizedDay = trackedDays.filter({ Calendar.current.dateComponents([.year, .month, .day], from: $0.day) == componentDay}).first else {
            return nil
        }
        return componentizedDay
    }
}
