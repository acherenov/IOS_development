//
//  UIView+copyView.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 08.04.2021.
//

import UIKit

extension UIView {
    
    func copyView<T: UIView>() -> T? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
        } catch {
            return nil
        }
    }
}
