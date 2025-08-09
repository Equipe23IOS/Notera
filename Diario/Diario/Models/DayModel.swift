//
//  EmojiModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 09/08/25.
//

import SwiftUI

class DayModel {
    var id = UUID()
    var emojiSprite: String
    var memo: String
    
    init(emojiSprite: String, memo: String) {
        self.emojiSprite = emojiSprite
        self.memo = memo
    }
}
