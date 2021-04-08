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
    let imageUrlString =
    "https://sun9-76.userapi.com/impf/c851432/v851432099/5f20f/GlaEkZJB5B4.jpg?size=550x330&quality=96&sign=e587fb32b50aaf31edaee78443d79e6d&type=album"
//    "https://sun9-48.userapi.com/impg/h_w0aadLiDCrp9yW0AqSCxyx_EsjPRlEGpUWqw/5gpkDnrV8FQ.jpg?size=1440x2160&quality=96&sign=d77bf2d839158e302513e767cb029be6&type=album"
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
