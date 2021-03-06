//
//  AssetsManagerProtocol.swift
//  ClipGo
//
//  Created by Алексей Черенов on 11.07.2020.
//

import Photos

protocol AssetsManagerProtocol {
    
    var authorizationStatus: PHAuthorizationStatus { get }
    
    func getSinglePhoto(_ completionHandler: @escaping ( _ photo: ImageAssetProtocol) -> Void)
    func getPhotosArray(maxCount: Int, completionHandler: @escaping (_ photos: [ImageAssetProtocol]) -> Void)
}
