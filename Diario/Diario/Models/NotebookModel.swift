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
    var sprite: String
    var date: Date = Date()
    var name: String
    
    init(name: String, sprite: String) {
        self.name = name
        self.sprite = sprite
    }
}
