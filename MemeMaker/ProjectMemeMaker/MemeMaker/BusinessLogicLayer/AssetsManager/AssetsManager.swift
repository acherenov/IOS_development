//
//  AssetsManager.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 22.10.2020.
//

import Foundation

class AssetsManager {
    
    static let shared: AssetsManagerProtocol = {
        if #available(iOS 14, *) {
            return PHAssetsManager()
        } else {
            return DKAssetsManager()
        }
    }()
}
