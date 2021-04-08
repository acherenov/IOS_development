//
//  ShapeOptionsView.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 08.04.2021.
//

import UIKit

class ShapeOptionsView: UIView {
    
    let stack = UIStackView()
    let heightSlider = UISlider()
    let widthSlider = UISlider()
    let cornerRadiusSlider = UISlider()

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
        
        addSubview(stack)
        stack.isUserInteractionEnabled = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 24
        
        setupSliderWithTitle(slider: heightSlider, title: R.string.localizable.height())
        heightSlider.minimumValue = 30
        setupSliderWithTitle(slider: widthSlider, title: R.string.localizable.width())
        widthSlider.minimumValue = 30
        setupSliderWithTitle(slider: cornerRadiusSlider, title: R.string.localizable.cornerRadius())

        makeConstraints()
    }
    
    private func setupSliderWithTitle(slider: UISlider, title: String?) {
        let label = UILabel()
        stack.addArrangedSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.gilroySemibold(size: 16)
        label.textColor = R.color.main()
        label.textAlignment = .left
        label.text = title
        stack.setCustomSpacing(16, after: label)
        
        stack.addArrangedSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = R.color.main()
        slider.minimumValue = 0
        slider.maximumValue = 100
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
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
}
