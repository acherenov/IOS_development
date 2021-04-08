//
//  TextOptionsView.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 08.04.2021.
//

import UIKit

class TextOptionsView: UIView {
    
    let buttonSideSize: CGFloat = 32
    
    let textAlignmentButtonLeft = ButtonWithTouchSize()
    let textAlignmentButtonRight = ButtonWithTouchSize()
    let textAlignmentButtonCenter = ButtonWithTouchSize()
    
    let sliderTitleLabel = UILabel()
    let fontSizeSlider = UISlider()
    
    let selectFontButton = ButtonWithTouchSize()

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
        
        setupRoundButton(textAlignmentButtonLeft, image: R.image.textAlignmentLeft())
        setupRoundButton(textAlignmentButtonCenter, image: R.image.textAlignmentCenter())
        setupRoundButton(textAlignmentButtonRight, image: R.image.textAlignmentRight())
        
        addSubview(sliderTitleLabel)
        sliderTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        sliderTitleLabel.font = R.font.gilroySemibold(size: 16)
        sliderTitleLabel.textColor = R.color.main()
        sliderTitleLabel.textAlignment = .left
        sliderTitleLabel.text = R.string.localizable.fontSize()
        
        addSubview(fontSizeSlider)
        fontSizeSlider.translatesAutoresizingMaskIntoConstraints = false
        fontSizeSlider.tintColor = R.color.main()
        fontSizeSlider.minimumValue = 2
        fontSizeSlider.maximumValue = 100

        addSubview(selectFontButton)
        UIStyleManager.buttonDefault(selectFontButton)
        selectFontButton.setTitle(R.string.localizable.chooseFont(), for: .normal)

        makeConstraints()
    }
    
    private func setupRoundButton(_ button: ButtonWithTouchSize, image: UIImage?) {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setDefaultAreaPadding()
        button.backgroundColor = .clear
        button.setImage(image, for: .normal)
        button.setImage(image, for: .selected)
        button.setImage(image, for: .highlighted)
        button.tintColor = R.color.main()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 220),
            
            textAlignmentButtonCenter.topAnchor.constraint(equalTo: topAnchor),
            textAlignmentButtonCenter.centerXAnchor.constraint(equalTo: centerXAnchor),
            textAlignmentButtonCenter.widthAnchor.constraint(equalToConstant: buttonSideSize),
            textAlignmentButtonCenter.heightAnchor.constraint(equalToConstant: buttonSideSize),
            
            textAlignmentButtonLeft.topAnchor.constraint(equalTo: textAlignmentButtonCenter.topAnchor),
            textAlignmentButtonLeft.rightAnchor.constraint(equalTo: textAlignmentButtonCenter.leftAnchor, constant: -24),
            textAlignmentButtonLeft.widthAnchor.constraint(equalToConstant: buttonSideSize),
            textAlignmentButtonLeft.heightAnchor.constraint(equalToConstant: buttonSideSize),
            
            textAlignmentButtonRight.topAnchor.constraint(equalTo: textAlignmentButtonCenter.topAnchor),
            textAlignmentButtonRight.leftAnchor.constraint(equalTo: textAlignmentButtonCenter.rightAnchor, constant: 24),
            textAlignmentButtonRight.widthAnchor.constraint(equalToConstant: buttonSideSize),
            textAlignmentButtonRight.heightAnchor.constraint(equalToConstant: buttonSideSize),
            
            sliderTitleLabel.bottomAnchor.constraint(equalTo: textAlignmentButtonCenter.bottomAnchor, constant: 48),
            sliderTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            sliderTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            
            fontSizeSlider.topAnchor.constraint(equalTo: sliderTitleLabel.bottomAnchor, constant: 16),
            fontSizeSlider.centerXAnchor.constraint(equalTo: centerXAnchor),
            fontSizeSlider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),

            selectFontButton.topAnchor.constraint(equalTo: fontSizeSlider.bottomAnchor, constant: 32),
            selectFontButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectFontButton.widthAnchor.constraint(equalTo: selectFontButton.titleLabel!.widthAnchor, constant: 50),
        ])
    }
}
