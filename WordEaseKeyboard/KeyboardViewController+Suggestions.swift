import UIKit

extension KeyboardViewController {
    // MARK: - Suggestion Bar
    func createSuggestionBar() -> UIView {
        let suggestionBar = UIStackView()
        suggestionBar.axis = .horizontal
        suggestionBar.distribution = .fillEqually
        suggestionBar.spacing = 8
        suggestionBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
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
        
        return suggestionBar
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
        guard let suggestionBar = keyboardStack?.arrangedSubviews.first as? UIStackView else { return }
        
        for i in 0..<3 {
            if let button = suggestionBar.arrangedSubviews[i] as? UIButton {
                button.setTitle(currentSuggestions[i], for: .normal)
                button.isHidden = currentSuggestions[i].isEmpty
            }
        }
    }
}
