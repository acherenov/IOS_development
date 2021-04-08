//
// Auto generated file
//

import UIKit

protocol ModuleGenerator {
    func createModule() -> UIViewController
}

enum UserStoriesModulesDefault: ModuleGenerator {

    case loading
    case templates
    case editor

    func createModule() -> UIViewController {
        switch self {
        case .loading: 
            return LoadingCoordinator.createModule()
        case .templates: 
            return TemplatesCoordinator.createModule()
        case .editor: 
            return EditorCoordinator.createModule()
        }
    }
}

enum UserStoriesModulesWithOutput: ModuleGenerator {

    case loading(output: LoadingOutput)
    case templates(output: TemplatesOutput)
    case editor(output: EditorOutput)

    func createModule() -> UIViewController {
        switch self {
        case .loading(let output): 
            return LoadingCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .templates(let output): 
            return TemplatesCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .editor(let output): 
            return EditorCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        }
    }
}
