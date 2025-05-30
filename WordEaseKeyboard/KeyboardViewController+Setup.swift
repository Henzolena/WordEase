import UIKit
import Foundation
import CoreGraphics

extension KeyboardViewController {
    // MARK: - Setup Methods
    internal func setupUI() {
        setupKeyboardLayout()
    }

    private func createFlexibleSpacer() -> UIView {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        return spacer
    }

    // Helper method to create a row of keys
    internal func addKeyRow(keys: [String], specialKeys: [String: UIColor]? = nil, useFillEqually: Bool) -> UIStackView {
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.spacing = Constants.spacing
        rowStack.distribution = useFillEqually ? .fillEqually : .fillProportionally
        
        for keyString in keys {
            let button = createButton(title: keyString)
            if let specialColor = specialKeys?[keyString] {
                button.backgroundColor = specialColor
            }
            rowStack.addArrangedSubview(button)
        }
        return rowStack
    }

    // Helper method to create a single key button
    internal func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: Constants.keyHeight).isActive = true
        button.addTarget(self, action: #selector(KeyboardViewController.keyPressed(_:)), for: .touchUpInside)
        return button
    }

    internal func setupKeyboardLayout() {
        keyboardStack?.removeFromSuperview()
        
        keyboardStack = UIStackView()
        keyboardStack.axis = .vertical
        keyboardStack.spacing = Constants.spacing
        keyboardStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(keyboardStack)
        
        NSLayoutConstraint.activate([
            keyboardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            keyboardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            keyboardStack.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.padding),
            keyboardStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.padding)
        ])
        
        let suggestionBar = createSuggestionBar()
        keyboardStack.addArrangedSubview(suggestionBar)
        
        if isExtendedSymbolsKeyboard {
            setupExtendedSymbolKeyboard()
        } else if isSymbolsKeyboard {
            setupSymbolKeyboard()
        } else {
            setupLetterKeyboard()
        }
    }

    func setupLetterKeyboard() {
        let keys1 = isShifted ? ["Q","W","E","R","T","Y","U","I","O","P"] : ["q","w","e","r","t","y","u","i","o","p"]
        let row1 = addKeyRow(keys: keys1, useFillEqually: true)
        keyboardStack.addArrangedSubview(row1)
        
        let keys2 = isShifted ? ["A","S","D","F","G","H","J","K","L"] : ["a","s","d","f","g","h","j","k","l"]
        let row2 = addKeyRow(keys: keys2, useFillEqually: true)
        row2.isLayoutMarginsRelativeArrangement = true
        row2.layoutMargins = UIEdgeInsets(top: 0, left: Constants.row2Indent, bottom: 0, right: Constants.row2Indent)
        keyboardStack.addArrangedSubview(row2)
        
        let keys3 = isShifted ? ["⇧","Z","X","C","V","B","N","M","⌫"] : ["⇧","z","x","c","v","b","n","m","⌫"]
        let row3 = addKeyRow(keys: keys3, specialKeys: ["⇧": UIColor.systemBlue, "⌫": UIColor.systemGray3], useFillEqually: true) // Changed to true
        row3.isLayoutMarginsRelativeArrangement = false
        row3.layoutMargins = UIEdgeInsets.zero
        
        if let shiftButton = row3.arrangedSubviews.first as? UIButton,
           let deleteButton = row3.arrangedSubviews.last as? UIButton {
            shiftButton.constraints.forEach { constraint in
                if constraint.firstAttribute == NSLayoutConstraint.Attribute.width {
                    shiftButton.removeConstraint(constraint)
                }
            }
            deleteButton.constraints.forEach { constraint in
                if constraint.firstAttribute == NSLayoutConstraint.Attribute.width {
                    deleteButton.removeConstraint(constraint)
                }
            }
            
            let shiftWidth = shiftButton.widthAnchor.constraint(equalToConstant: Constants.deleteKeyWidth)
            let deleteWidth = deleteButton.widthAnchor.constraint(equalToConstant: Constants.deleteKeyWidth)
            shiftWidth.priority = UILayoutPriority.required
            deleteWidth.priority = UILayoutPriority.required
            NSLayoutConstraint.activate([shiftWidth, deleteWidth])
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                print("Delete button frame in letter keyboard: \(deleteButton.frame)")
            }
        }
        
        keyboardStack.addArrangedSubview(row3)
        
        let row4 = addKeyRow(keys: ["123", "😀", "space", ".", "Go"], specialKeys: ["123": UIColor.systemGray3, "😀": UIColor.systemGray3, ".": UIColor.systemGray3, "Go": UIColor.systemBlue], useFillEqually: false)
        row4.isLayoutMarginsRelativeArrangement = false
        row4.layoutMargins = UIEdgeInsets.zero
        
        for (index, view) in row4.arrangedSubviews.enumerated() {
            guard let button = view as? UIButton else { continue }
            
            button.constraints.filter { $0.firstAttribute == NSLayoutConstraint.Attribute.width }.forEach { button.removeConstraint($0) }
            
            let keyString = ["123", "😀", "space", ".", "Go"][index]
            let keyWidth: CGFloat
            
            switch keyString {
            case "123":
                keyWidth = Constants.numbersKeyWidth
            case "😀":
                keyWidth = Constants.emojiKeyWidth
            case "space":
                keyWidth = Constants.spaceKeyWidth
            case ".":
                keyWidth = Constants.periodKeyWidth
            case "Go":
                keyWidth = Constants.goKeyWidth
            default:
                keyWidth = Constants.standardKeyWidth
            }
            
            let widthConstraint = button.widthAnchor.constraint(equalToConstant: keyWidth)
            widthConstraint.priority = UILayoutPriority.required
            widthConstraint.isActive = true
        }
        
        keyboardStack.addArrangedSubview(row4)
    }

    func setupSymbolKeyboard() {
        let numbersRow = addKeyRow(keys: Constants.symbolKeys[0], useFillEqually: true)
        keyboardStack.addArrangedSubview(numbersRow)
        
        let symbolsRow1 = addKeyRow(keys: Constants.symbolKeys[1], useFillEqually: true)
        keyboardStack.addArrangedSubview(symbolsRow1)
        
        let thirdRowKeys = Constants.symbolKeys[2]
        let symbolsRow2 = UIStackView() // Manually create stack view
        symbolsRow2.axis = .horizontal
        symbolsRow2.spacing = Constants.spacing
        symbolsRow2.distribution = .equalCentering // Changed to equalCentering
        symbolsRow2.translatesAutoresizingMaskIntoConstraints = false
        
        // Add keys
        for keyString in thirdRowKeys {
            let button = createButton(title: keyString)
            if let specialColor = ["#+=": UIColor.systemGray3, "⌫": UIColor.systemGray3][keyString] {
                button.backgroundColor = specialColor
            }
            
            let keyWidth: CGFloat
            switch keyString {
            case "#+=":
                keyWidth = Constants.deleteKeyWidth // Changed to match delete button width
            case "⌫":
                keyWidth = Constants.deleteKeyWidth
            default:
                keyWidth = Constants.standardKeyWidth
            }
            
            let widthConstraint = button.widthAnchor.constraint(equalToConstant: keyWidth)
            widthConstraint.priority = UILayoutPriority.required
            widthConstraint.isActive = true
            
            symbolsRow2.addArrangedSubview(button) // Add button directly
            
            if keyString == "⌫" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    print("Delete button frame in symbol keyboard: \(button.frame)")
                }
            }
        }
        
        keyboardStack.addArrangedSubview(symbolsRow2)
        
        let bottomRow = addKeyRow(keys: Constants.symbolKeys[3],
                                 specialKeys: ["ABC": UIColor.systemGray3, "Go": UIColor.systemBlue],
                                 useFillEqually: false)
        bottomRow.isLayoutMarginsRelativeArrangement = false
        bottomRow.layoutMargins = UIEdgeInsets.zero
        
        if let abcButton = bottomRow.arrangedSubviews.first as? UIButton,
           let goButton = bottomRow.arrangedSubviews.last as? UIButton {
            abcButton.constraints.filter { $0.firstAttribute == NSLayoutConstraint.Attribute.width }.forEach { abcButton.removeConstraint($0) }
            goButton.constraints.filter { $0.firstAttribute == NSLayoutConstraint.Attribute.width }.forEach { goButton.removeConstraint($0) }
            
            let abcWidth = abcButton.widthAnchor.constraint(equalToConstant: Constants.numbersKeyWidth)
            let goWidth = goButton.widthAnchor.constraint(equalToConstant: Constants.numbersKeyWidth)
            abcWidth.priority = UILayoutPriority.required
            goWidth.priority = UILayoutPriority.required
            NSLayoutConstraint.activate([abcWidth, goWidth])
        }
        keyboardStack.addArrangedSubview(bottomRow)
    }

    func setupExtendedSymbolKeyboard() {
        let symbolsRow1 = addKeyRow(keys: Constants.extendedSymbolKeys[0], useFillEqually: true)
        keyboardStack.addArrangedSubview(symbolsRow1)
        
        let symbolsRow2 = addKeyRow(keys: Constants.extendedSymbolKeys[1], useFillEqually: true)
        keyboardStack.addArrangedSubview(symbolsRow2)
        
        let thirdRowKeys = Constants.extendedSymbolKeys[2]
        let controlRow = UIStackView() // Manually create stack view
        controlRow.axis = .horizontal
        controlRow.spacing = Constants.spacing
        controlRow.distribution = .equalCentering // Changed to equalCentering
        controlRow.translatesAutoresizingMaskIntoConstraints = false
        
        for keyString in thirdRowKeys {
            let button = createButton(title: keyString)
            if let specialColor = ["123": UIColor.systemGray3, "⌫": UIColor.systemGray3][keyString] {
                button.backgroundColor = specialColor
            }
            
            let keyWidth: CGFloat
            switch keyString {
            case "123":
                keyWidth = Constants.deleteKeyWidth // Changed to match delete button width
            case "⌫":
                keyWidth = Constants.deleteKeyWidth
            default:
                keyWidth = Constants.standardKeyWidth
            }
            
            let widthConstraint = button.widthAnchor.constraint(equalToConstant: keyWidth)
            widthConstraint.priority = UILayoutPriority.required
            widthConstraint.isActive = true
            
            controlRow.addArrangedSubview(button) // Add button directly
            
            if keyString == "⌫" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    print("Delete button frame in extended symbol keyboard: \(button.frame)")
                }
            }
        }
        
        keyboardStack.addArrangedSubview(controlRow)
        
        let bottomRow = addKeyRow(keys: Constants.extendedSymbolKeys[3],
                                 specialKeys: ["ABC": UIColor.systemGray3, "Go": UIColor.systemBlue],
                                 useFillEqually: false)
        bottomRow.isLayoutMarginsRelativeArrangement = false
        bottomRow.layoutMargins = UIEdgeInsets.zero
        
        if let abcButton = bottomRow.arrangedSubviews.first as? UIButton,
           let goButton = bottomRow.arrangedSubviews.last as? UIButton {
            abcButton.constraints.forEach { constraint in
                if constraint.firstAttribute == NSLayoutConstraint.Attribute.width {
                    abcButton.removeConstraint(constraint)
                }
            }
            goButton.constraints.forEach { constraint in
                if constraint.firstAttribute == NSLayoutConstraint.Attribute.width {
                    goButton.removeConstraint(constraint)
                }
            }
            
            let abcWidth = abcButton.widthAnchor.constraint(equalToConstant: Constants.numbersKeyWidth)
            let goWidth = goButton.widthAnchor.constraint(equalToConstant: Constants.numbersKeyWidth)
            abcWidth.priority = UILayoutPriority.required
            goWidth.priority = UILayoutPriority.required
            NSLayoutConstraint.activate([abcWidth, goWidth])
        }
        
        keyboardStack.addArrangedSubview(bottomRow)
    }
}
