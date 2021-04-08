//
//  UIStyleManager.swift
//  MemeMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import UIKit

class UIStyleManager {
    
    // MARK: - UIBarButtonItem
    
    static func setUIBarButtonItemsClear() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear],
                                                            for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear],
                                                            for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear],
                                                            for: .focused)
    }
    
    static func setUIBarButtonItemsDefault() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: R.color.tintColorLight()!],
                                                            for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: R.color.tintColorLight()!],
                                                            for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: R.color.tintColorLight()!],
                                                            for: .focused)
    }
    
    // MARK: - UIView
    
    static func textDefaultInput(_ view: UIView, addHeightConstraint: Bool = true) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = R.color.lightGray()

        guard addHeightConstraint
        else { return }
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    static func shadow(_ view: UIView) {
        view.layer.shadowColor = R.color.gray()?.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    // MARK: - UINavigationController
    
    static func navigationControllerTransparent(_ controller: UINavigationController) {
        controller.view.backgroundColor = .clear
        controller.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationBar.shadowImage = UIImage()
        controller.navigationBar.isTranslucent = true
        
        controller.navigationBar.tintColor = R.color.tintColorLight()
        controller.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: R.font.gilroyBold(size: 20)!,
                                                        NSAttributedString.Key.foregroundColor: R.color.tintColorLight()!]
    }
    
    // MARK: - UITextField
    
    static func textFieldDefault(textField: UITextField, placeholderText: String) {
        textDefaultInput(textField)
        textField.font = R.font.gilroyBold(size: 14)
        textField.setLeftPaddingPoints(24)
        textField.setRightPaddingPoints(24)

        let attributes = [
            NSAttributedString.Key.foregroundColor: R.color.gray()!,
            NSAttributedString.Key.font: R.font.gilroyRegular(size: 14)!
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                             attributes: attributes)
    }
    
    // MARK: - UIButton
    
    static func buttonDefault(_ button: ButtonWithTouchSize) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = R.color.main()
        button.layer.cornerRadius = 30
        button.setTitleColor(R.color.tintColorLight(), for: .normal)
        button.setTitleColor(R.color.tintColorLight(), for: .selected)
        button.setTitleColor(R.color.tintColorLight(), for: .highlighted)
        button.titleLabel?.font = R.font.gilroySemibold(size: 16)
        button.setDefaultAreaPadding()
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
