//
//  LoadingCoordinator.swift
//  MemeMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import UIKit

final class LoadingCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableLoadingViewModel) -> Void)? = nil) -> UIViewController {
        let view = LoadingViewController()
        let viewModel = LoadingViewModel()
        let coordinator = LoadingCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view

        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view
extension LoadingCoordinator: LoadingCoordinatorProtocol {

    func showTemplates() {
        let vc = TemplatesCoordinator.createModule()
        transition.showInNewRootNavigationStack(controller: vc)
    }
}
