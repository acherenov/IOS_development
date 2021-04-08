//
//  TemplatesCoordinator.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 03.04.2021.
//

import UIKit

final class TemplatesCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableTemplatesViewModel) -> Void)? = nil) -> UIViewController {
        let view = TemplatesViewController()
        let viewModel = TemplatesViewModel()
        let coordinator = TemplatesCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view
        
        viewModel.assetsManager = AssetsManager.shared

        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view
extension TemplatesCoordinator: TemplatesCoordinatorProtocol {

    func showEditor(template: MemeTemplate) {
        let vc = EditorCoordinator.createModule { viewModel in
            viewModel.template = template
        }
        transition.showInNavigationController(vc)
    }
}
