//
//  MemeTemplates.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 04.04.2021.
//

import UIKit
import SDWebImage

protocol MemeTemplate {
    
    func loadImage(_ completion: @escaping(UIImage?) -> Void)
}

struct MemeTemplateRemote: MemeTemplate {
    
    let imageUrlString: String
    var imageUrl: URL? {
        return URL(string: imageUrlString)
    }
    
    func loadImage(_ completion: @escaping(UIImage?) -> Void) {
        SDWebImageManager.shared.loadImage(with: imageUrl,
                                           options: .continueInBackground,
                                           progress: nil) { image, _, _, _, _, _   in
            completion(image)
        }
    }
}

struct MemeTemplateLocal: MemeTemplate {
    
    let image: UIImage?
    
    func loadImage(_ completion: @escaping(UIImage?) -> Void) {
        completion(image)
    }
}
