//
//  NotebookModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 01/06/25.
//

import SwiftUI

struct NotebookModel: Identifiable {
    let id = UUID()
    var entries: [DiaryContent] = []
    let date: Date = Date()
}
