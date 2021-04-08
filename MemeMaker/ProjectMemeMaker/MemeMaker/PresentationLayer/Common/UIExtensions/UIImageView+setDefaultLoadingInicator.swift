//
//  UIImageView+setDefaultLoadingInicator.swift
//  ClubhouseAvatarMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import SDWebImage
import UIKit

extension UIImageView {
    
    func setDefaultLoadingInicator() {
        sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
    }
}
