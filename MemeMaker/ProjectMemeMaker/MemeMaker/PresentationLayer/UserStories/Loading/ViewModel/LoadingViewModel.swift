//
//  LoadingViewModel.swift
//  MemeMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

final class LoadingViewModel {
	var output: LoadingOutput?
}

// MARK: - Configuration
extension LoadingViewModel: CustomizableLoadingViewModel {

}

// MARK: - Interface for view
extension LoadingViewModel: LoadingViewModelProtocol {
    
    func startConfiguration() {
        
    }
}

