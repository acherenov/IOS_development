//
//  TemplatesViewModel.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 03.04.2021.
//

final class TemplatesViewModel {
    
	var output: TemplatesOutput?
    
    var assetsManager: AssetsManagerProtocol!
}

// MARK: - Configuration
extension TemplatesViewModel: CustomizableTemplatesViewModel {

}

// MARK: - Interface for view
extension TemplatesViewModel: TemplatesViewModelProtocol {
    
    func pickNewPhotoFromAssets(_ completionHandler: @escaping (ImageAssetProtocol) -> Void) {
        assetsManager.getSinglePhoto(completionHandler)
    }
}

