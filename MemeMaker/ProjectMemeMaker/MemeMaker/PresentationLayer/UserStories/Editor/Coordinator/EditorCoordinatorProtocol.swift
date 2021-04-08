//
//  EditorCoordinatorProtocol.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 05.04.2021.
//

protocol EditorCoordinatorProtocol: DefaultCoordinatorProtocol {
    
    func showTextEditor(startText: String, output: TextEditorOutput)
}
