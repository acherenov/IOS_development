//
//  EditorInput.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 05.04.2021.
//

protocol CustomizableEditorViewModel: class {
    
    var output: EditorOutput? { get set }
    
    var template: MemeTemplate! { get set }
}
