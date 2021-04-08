//
//  TextEditorViewModel.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 08.04.2021.
//

final class TextEditorViewModel {
	var output: TextEditorOutput?
    
    var text: String = ""
    var maxTextLength: Int?
}

// MARK: - Configuration
extension TextEditorViewModel: CustomizableTextEditorViewModel {

}

// MARK: - Interface for view
extension TextEditorViewModel: TextEditorViewModelProtocol {
    
    func save(_ editedText: String) {
        output?.returnEditedText(editedText)
    }
}

