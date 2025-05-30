import UIKit
import ObjectiveC
import Foundation
import CoreGraphics

class KeyboardViewController: UIInputViewController {

    // MARK: - Properties
    var keyboardStack: UIStackView!
    var isShifted = false
    var isSymbolsKeyboard = false
    var isExtendedSymbolsKeyboard = false
    var lastCharWasPeriod = false
    var currentSuggestions: [String] = ["", "", ""]
    var emojiView: UIView?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Input view height: \(view.frame.height)")
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preferredContentSize = CGSize(width: view.frame.width, height: 228)
    }

    // MARK: - Actions
    @objc func keyPressed(_ sender: UIButton) {
        guard let key = sender.titleLabel?.text else { return }
        let proxy = textDocumentProxy
        UIDevice.current.playInputClick()
        
        switch key {
        case "space":
            proxy.insertText(" ")
            lastCharWasPeriod = false
            generateSuggestions()
        case "Go":
            proxy.insertText("\n")
            lastCharWasPeriod = false
        case "⌫":
            proxy.deleteBackward()
            lastCharWasPeriod = false
            generateSuggestions()
        case "123":
            if isExtendedSymbolsKeyboard {
                isExtendedSymbolsKeyboard = false
                isSymbolsKeyboard = true
            } else {
                isSymbolsKeyboard = true
                isExtendedSymbolsKeyboard = false
            }
            setupKeyboardLayout()
        case "ABC":
            isSymbolsKeyboard = false
            isExtendedSymbolsKeyboard = false
            setupKeyboardLayout()
        case "#+=":
            isExtendedSymbolsKeyboard = true
            isSymbolsKeyboard = false
            setupKeyboardLayout()
        case "⇧":
            isShifted = !isShifted
            setupKeyboardLayout()
        case "😀":
            toggleEmojiKeyboard()
        case ".":
            proxy.insertText(".")
            lastCharWasPeriod = true
            generateSuggestions()
        default:
            if isSymbolsKeyboard || isExtendedSymbolsKeyboard {
                proxy.insertText(key)
            } else {
                proxy.insertText(key)
                if isShifted && !lastCharWasPeriod {
                    isShifted = false
                    setupKeyboardLayout()
                }
            }
            if lastCharWasPeriod && key == " " {
                isShifted = true
                setupKeyboardLayout()
                lastCharWasPeriod = false
            }
            generateSuggestions()
        }
    }

    // MARK: - UITextDocumentProxy Helpers
    override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
        generateSuggestions()
        
        if let char = textDocumentProxy.documentContextBeforeInput?.last,
           [".","!","?"].contains(char) {
            lastCharWasPeriod = true
        } else if let text = textDocumentProxy.documentContextBeforeInput,
                  text.isEmpty || text.hasSuffix("\n") {
            isShifted = true
            if !isSymbolsKeyboard && !isExtendedSymbolsKeyboard {
                 setupKeyboardLayout()
            }
        } else if textDocumentProxy.documentContextBeforeInput?.last != " " {
            if lastCharWasPeriod && !(textDocumentProxy.documentContextBeforeInput?.isEmpty ?? true) {
                if isShifted {
                    isShifted = false
                    if !isSymbolsKeyboard && !isExtendedSymbolsKeyboard {
                        setupKeyboardLayout()
                    }
                }
            }
            lastCharWasPeriod = false
        }
    }
}
