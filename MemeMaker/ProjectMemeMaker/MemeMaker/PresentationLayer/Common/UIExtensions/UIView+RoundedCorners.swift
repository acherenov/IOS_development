//
//  UIView+RoundedCorners.swift
//  ClubhouseAvatarMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import UIKit

extension UIView {
    
    func roundCorners(corners: CACornerMask, radius: CGFloat = 8) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}
