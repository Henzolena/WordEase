import UIKit

extension KeyboardViewController {
    // MARK: - Suggestion Bar
    func createSuggestionBar() -> UIView {
        let suggestionBar = UIStackView()
        suggestionBar.axis = .horizontal
        suggestionBar.distribution = .fillEqually
        suggestionBar.spacing = 8
        suggestionBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Add suggestion buttons
        for i in 0..<3 {
            let button = UIButton(type: .system)
            button.setTitle("", for: .normal)
            button.backgroundColor = .tertiarySystemBackground
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.systemGray4.cgColor
            button.tag = i
            button.addTarget(self, action: #selector(suggestionTapped(_:)), for: .touchUpInside)
            suggestionBar.addArrangedSubview(button)
        }
        
        // Add AI feature buttons (placeholders for Phase 2)
        let aiButtonsStack = UIStackView()
        aiButtonsStack.axis = .horizontal
        aiButtonsStack.distribution = .fillEqually
        aiButtonsStack.spacing = 8
        
        let aiFeatures = ["Rewrite", "Formal", "Casual", "Concise", "Expand"]
        for feature in aiFeatures {
            let button = UIButton(type: .system)
            button.setTitle(feature, for: .normal)
            button.backgroundColor = .systemGray5
            button.setTitleColor(.label, for: .normal)
            button.layer.cornerRadius = 5
            button.addTarget(self, action: #selector(aiFeatureTapped(_:)), for: .touchUpInside)
            aiButtonsStack.addArrangedSubview(button)
        }
        
        let mainToolbarStack = UIStackView(arrangedSubviews: [suggestionBar, aiButtonsStack])
        mainToolbarStack.axis = .vertical
        mainToolbarStack.spacing = 8
        mainToolbarStack.translatesAutoresizingMaskIntoConstraints = false
        
        return mainToolbarStack
    }

    @objc func aiFeatureTapped(_ sender: UIButton) {
        guard let feature = sender.titleLabel?.text else { return }
        print("AI Feature tapped: \(feature)")
        // Placeholder for AI integration in Phase 2
        // This will trigger AI rewrite/tone adjustment based on the feature
    }

    @objc func suggestionTapped(_ sender: UIButton) {
        let index = sender.tag
        if index < currentSuggestions.count && !currentSuggestions[index].isEmpty {
            if let currentWord = getCurrentWord() {
                for _ in 0..<currentWord.count {
                    textDocumentProxy.deleteBackward()
                }
                textDocumentProxy.insertText(currentSuggestions[index])
                generateSuggestions()
            }
        }
    }

    func getCurrentWord() -> String? {
        guard let text = textDocumentProxy.documentContextBeforeInput else { return nil }
        let components = text.components(separatedBy: .whitespacesAndNewlines)
        return components.last
    }

    func generateSuggestions() {
        currentSuggestions = ["", "", ""]
        guard let currentWord = getCurrentWord(), !currentWord.isEmpty else { 
            updateSuggestionBar()
            return 
        }
        
        let commonWords = [
            "the", "be", "to", "of", "and", "a", "in", "that", "have", "I",
            "it", "for", "not", "on", "with", "he", "as", "you", "do", "at",
            "this", "but", "his", "by", "from", "they", "we", "say", "her", "she",
            "or", "an", "will", "my", "one", "all", "would", "there", "their", "what"
        ]
        
        var suggestions: [String] = []
        
        for word in commonWords {
            if word.hasPrefix(currentWord.lowercased()) && word != currentWord.lowercased() {
                suggestions.append(word)
                if suggestions.count >= 3 {
                    break
                }
            }
        }
        
        for (index, suggestion) in suggestions.enumerated() {
            if index < 3 {
                currentSuggestions[index] = suggestion
            }
        }
        
        updateSuggestionBar()
    }

    func updateSuggestionBar() {
        // Get the mainToolbarStack which is the first arranged subview of keyboardStack
        guard let mainToolbarStack = keyboardStack?.arrangedSubviews.first as? UIStackView else { return }
        
        // Get the actual suggestionBar which is the first arranged subview of mainToolbarStack
        guard let suggestionBar = mainToolbarStack.arrangedSubviews.first as? UIStackView else { return }
        
        for i in 0..<3 {
            if let button = suggestionBar.arrangedSubviews[i] as? UIButton {
                button.setTitle(currentSuggestions[i], for: .normal)
                button.isHidden = currentSuggestions[i].isEmpty
            }
        }
    }
}
