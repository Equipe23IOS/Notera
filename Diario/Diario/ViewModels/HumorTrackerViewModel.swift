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
    }
    
    func deleteDay(_ day: DayModel) {
        database.deleteDay(day: day)
        trackedDays.removeAll(where: { $0.id == day.id })
    }
    
    func updateDay(_ day: DayModel) {
        guard let index = trackedDays.firstIndex(where: { $0.id == day.id }) else {
            return
        }
        
        database.updateDay(day: trackedDays[index], updatedDay: day)
        trackedDays[index] = day
    }
}
