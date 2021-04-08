//
//  EditorCoordinator.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 05.04.2021.
//

import UIKit

final class EditorCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableEditorViewModel) -> Void)? = nil) -> UIViewController {
        let view = EditorViewController()
        let viewModel = EditorViewModel()
        let coordinator = EditorCoordinator()

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
extension EditorCoordinator: EditorCoordinatorProtocol {

    func showTextEditor(startText: String, output: TextEditorOutput) {
        let vc = TextEditorCoordinator.createModule { viewModel in
            viewModel.text = startText
            viewModel.output = output
        }
        transition.showInNavigationController(vc)
    }
}
