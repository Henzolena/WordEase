import UIKit

extension KeyboardViewController {
    // MARK: - Constants
    struct Constants {
        static let keyHeight: CGFloat = 50.0
        static let cornerRadius: CGFloat = 8.0
        static let borderWidth: CGFloat = 0.5
        static let spacing: CGFloat = 6.0
        static let rowSpacing: CGFloat = 6.0
        static let padding: CGFloat = 6.0
        static let fontSize: CGFloat = 22.0
        static let standardKeyWidth: CGFloat = 36.0
        static let deleteKeyWidth: CGFloat = 60.0
        static let row2Indent: CGFloat = 16.0
        static let availableWidth: CGFloat = 416.0
        static let numbersKeyWidth: CGFloat = 0.15 * availableWidth
        static let emojiKeyWidth: CGFloat = 0.10 * availableWidth
        static let spaceKeyWidth: CGFloat = 0.50 * availableWidth
        static let periodKeyWidth: CGFloat = 0.10 * availableWidth
        static let goKeyWidth: CGFloat = 0.15 * availableWidth
        static let symbolRow3SpecialKeyWidth: CGFloat = 100.0 // For #+=, ⌫ in symbol keyboard, and 123, ⌫ in extended symbol keyboard
        
        static let symbolKeys: [[String]] = [
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
            ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""], // Corrected: """ to "\""
            ["#+=", ".", ",", "?", "!", "\'", "⌫"],
            ["ABC", "space", "Go"]
        ]
        static let extendedSymbolKeys: [[String]] = [
            ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
            ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"],
            ["123", ".", ",", "?", "!", "\'", "⌫"],
            ["ABC", "space", "Go"]
        ]
    }
}
