//
//  UIView+snapshot.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 07.04.2021.
//

import UIKit

extension UIView {
    
    func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        defer { UIGraphicsEndImageContext() }
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}
