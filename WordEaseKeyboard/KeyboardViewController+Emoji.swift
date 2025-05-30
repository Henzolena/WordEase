import UIKit

extension KeyboardViewController {
    // MARK: - Emoji Keyboard
    func toggleEmojiKeyboard() {
        if let emojiView = self.emojiView {
            emojiView.removeFromSuperview()
            self.emojiView = nil
            // Restore keyboardStack if it was hidden or removed
            if keyboardStack.superview == nil {
                view.addSubview(keyboardStack)
                // Re-apply constraints
                 NSLayoutConstraint.activate([
                    keyboardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
                    keyboardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
                    keyboardStack.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.padding),
                    keyboardStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.padding)
                ])
            }
            setupKeyboardLayout() // Re-setup the main keyboard
            return
        }

        // Remove or hide the main keyboard before showing emoji view
        keyboardStack?.removeFromSuperview()

        let emojiView = UIView()
        emojiView.backgroundColor = .systemBackground
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emojiView)
        
        NSLayoutConstraint.activate([
            emojiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emojiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emojiView.topAnchor.constraint(equalTo: view.topAnchor),
            emojiView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let commonEmojis = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "😊", "😇",
                            "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘", "😗", "😙", "😚"]
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: emojiView.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: emojiView.trailingAnchor, constant: -10),
            scrollView.topAnchor.constraint(equalTo: emojiView.topAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: emojiView.bottomAnchor, constant: -60)
        ])
        
        let emojiStackView = UIStackView()
        emojiStackView.axis = .vertical
        emojiStackView.spacing = 10
        emojiStackView.distribution = .fillEqually
        emojiStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(emojiStackView)
        
        NSLayoutConstraint.activate([
            emojiStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            emojiStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            emojiStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            emojiStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            emojiStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        var currentRow: UIStackView?
        
        for (index, emoji) in commonEmojis.enumerated() {
            if index % 5 == 0 {
                currentRow = UIStackView()
                currentRow!.axis = .horizontal
                currentRow!.distribution = .fillEqually
                currentRow!.spacing = 10
                emojiStackView.addArrangedSubview(currentRow!)
            }
            
            let button = UIButton(type: .system)
            button.setTitle(emoji, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 30)
            button.addTarget(self, action: #selector(emojiTapped(_:)), for: .touchUpInside)
            currentRow?.addArrangedSubview(button)
        }
        
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeEmojiKeyboard), for: .touchUpInside)
        emojiView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.centerXAnchor.constraint(equalTo: emojiView.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: emojiView.bottomAnchor, constant: -10),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.emojiView = emojiView
    }

    @objc func emojiTapped(_ sender: UIButton) {
        if let emoji = sender.title(for: .normal) {
            textDocumentProxy.insertText(emoji)
        }
        // Not closing emoji keyboard automatically to allow multiple emoji input
        // closeEmojiKeyboard() 
    }

    @objc func closeEmojiKeyboard() {
        if let emojiView = self.emojiView {
            emojiView.removeFromSuperview()
            self.emojiView = nil
        }
        if keyboardStack.superview == nil {
             view.addSubview(keyboardStack)
             NSLayoutConstraint.activate([
                keyboardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
                keyboardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
                keyboardStack.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.padding),
                keyboardStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.padding)
            ])
        }
        setupKeyboardLayout() 
    }
}
