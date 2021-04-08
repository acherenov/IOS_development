//
//  String+capitalizingFirstLetter.swift
//  ClubhouseAvatarMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
