//
//  UIScrollView+ScrollToBottom.swift
//  ClubhouseAvatarMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import UIKit

extension UIScrollView {
    
    func scrollsToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
}
