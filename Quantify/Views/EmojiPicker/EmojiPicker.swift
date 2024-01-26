//
//  EmojiPicker.swift
//  Quantify
//
//  Created by David Hermann on 25.01.24.
//

import ElegantEmojiPicker
import SwiftUI

class EmojiPickerBridge: NSObject, ElegantEmojiPickerDelegate {
    let emojiSelectionHandler: (Emoji?) -> Void

    init(emojiSelectionHandler: @escaping (Emoji?) -> Void) {
        self.emojiSelectionHandler = emojiSelectionHandler
    }

    func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
        emojiSelectionHandler(emoji)
    }
}

struct ElegantEmojiPickerView: UIViewControllerRepresentable {
    var delegate: ElegantEmojiPickerDelegate

    func makeUIViewController(context: Context) -> ElegantEmojiPicker {
        ElegantEmojiPicker(delegate: delegate)
    }

    func updateUIViewController(_ uiViewController: ElegantEmojiPicker, context: Context) {
        // Optional: Code zur Aktualisierung des View Controllers
    }
}
