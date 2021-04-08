//
//  TextEditorCoordinator.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 08.04.2021.
//

import UIKit

final class TextEditorCoordinator {
    
    weak var transition: ModuleTransitionHandler!

    static func createModule(_ configuration: ((CustomizableTextEditorViewModel) -> Void)? = nil) -> UIViewController {
        let view = TextEditorViewController()
        let viewModel = TextEditorViewModel()
        let coordinator = TextEditorCoordinator()

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
extension TextEditorCoordinator: TextEditorCoordinatorProtocol {

    func dismiss() {
        transition.dismissSelf()
    }
}
