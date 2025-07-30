//
//  NotebookModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 01/06/25.
//

import SwiftUI
import SwiftData

@Model
class NotebookModel: Identifiable {
    var id = UUID()
    var entries: [DiaryContent] = []
    var date: Date = Date()
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
