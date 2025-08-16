//
//  EmojiModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 09/08/25.
//

import SwiftUI

class DayModel {
    var id = UUID()
    var day: Date
    var emojiSprite: String
    var memo: String
    
    init(day: Date, emojiSprite: String, memo: String) {
        self.day = day
        self.emojiSprite = emojiSprite
        self.memo = memo
    }
}
