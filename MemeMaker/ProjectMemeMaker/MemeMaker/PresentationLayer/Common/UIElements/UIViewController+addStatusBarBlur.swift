//
//  UIViewController+addStatusBarBlur.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 04.04.2021.
//

import UIKit

extension UIViewController {
    
    func addStatusBarBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurEffectView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurEffectView.heightAnchor.constraint(equalToConstant: UIConstants.statusBarHeight)
        ])
    }
}
