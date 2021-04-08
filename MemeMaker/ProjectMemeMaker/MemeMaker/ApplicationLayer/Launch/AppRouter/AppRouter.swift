//
//  AppRouter.swift
//  MemeMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import UIKit

protocol AppRouter: class {

	var window: UIWindow! { get set }
    
    func handleLaunch()
}
