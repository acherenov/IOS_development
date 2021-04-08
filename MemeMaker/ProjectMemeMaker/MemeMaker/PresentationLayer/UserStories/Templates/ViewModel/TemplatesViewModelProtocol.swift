//
//  TemplatesViewModelProtocol.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 03.04.2021.
//

protocol TemplatesViewModelProtocol: class {
    
    var templates: [MemeTemplate] { get }
    
    func pickNewPhotoFromAssets(_ completionHandler: @escaping (ImageAssetProtocol) -> Void)
}
