//
//  HumorTrackerViewModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 09/08/25.
//

import SwiftUI

class HumorTrackerViewModel: ObservableObject {
    @Published var trackedDays: [DayModel] = []
    
    func createDay(_ selectedSprite: String, _ memo: String) {
        let day = DayModel(emojiSprite: selectedSprite, memo: memo)
        trackedDays.append(day)
    }
    
    func deleteDay(_ day: DayModel) {
        trackedDays.removeAll(where: { $0.id == day.id })
    }
    
    func updateDay(_ day: DayModel) {
        guard let index = trackedDays.firstIndex(where: { $0.id == day.id }) else {
            return
        }
        
        trackedDays[index] = day
    }
}
