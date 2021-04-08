//
//  EditorViewModel.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 05.04.2021.
//

final class EditorViewModel {
	var output: EditorOutput?
    
    var template: MemeTemplate!
}

// MARK: - Configuration
extension EditorViewModel: CustomizableEditorViewModel {

}

// MARK: - Interface for view
extension EditorViewModel: EditorViewModelProtocol {

}

