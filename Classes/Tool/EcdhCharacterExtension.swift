//
//  EcdhCharacterExtension.swift
//
//  Created by MorganChen on 2025/3/26.
//

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var containEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    /// Checks if the scalars will be merged into an emoji
    var combinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmojiChar: Bool { containEmoji || combinedIntoEmoji }
}
