//
//  ColorOptionsView.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 08.04.2021.
//

import UIKit

class ColorOptionsView: UIView {
    
    let fontColorButton = ButtonWithTouchSize()
    let backgroundColorButton = ButtonWithTouchSize()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        backgroundColor = R.color.tintColorLight()
        
        addSubview(fontColorButton)
        UIStyleManager.buttonDefault(fontColorButton)
        fontColorButton.setTitle(R.string.localizable.chooseLabelTextColor(), for: .normal)
        
        addSubview(backgroundColorButton)
        UIStyleManager.buttonDefault(backgroundColorButton)
        backgroundColorButton.setTitle(R.string.localizable.chooseLabelBackgroundColor(), for: .normal)

        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 180),
            
            fontColorButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            fontColorButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            fontColorButton.widthAnchor.constraint(equalTo: fontColorButton.titleLabel!.widthAnchor, constant: 50),
            
            backgroundColorButton.topAnchor.constraint(equalTo: fontColorButton.bottomAnchor, constant: 32),
            backgroundColorButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundColorButton.widthAnchor.constraint(equalTo: backgroundColorButton.titleLabel!.widthAnchor, constant: 50)
        ])
    }
}
