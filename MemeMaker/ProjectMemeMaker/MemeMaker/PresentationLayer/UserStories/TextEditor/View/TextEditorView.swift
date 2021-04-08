//
//  TextEditorView.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 08.04.2021.
//

import UIKit

final class TextEditorView: UIView {
    
    let editor = LimitatableTextView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.backgroundLight()
        
        addSubview(editor)
        editor.translatesAutoresizingMaskIntoConstraints = false
        editor.placeholder.text = R.string.localizable.placeholderText()
        editor.countLabel.textColor = R.color.main()

        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            editor.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            editor.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 24),
            editor.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -24)
        ])
    }
}
