//
//  DiaryContent.swift
//  Diario
//
//  Created by iredefbmac_36 on 13/05/25.
//

import SwiftUI

struct DiaryContent: Codable, Identifiable {
    var id = UUID()
    var title: String
    var entry: String
}
