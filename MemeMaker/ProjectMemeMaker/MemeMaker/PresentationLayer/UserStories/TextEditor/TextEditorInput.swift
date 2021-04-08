//
//  TextEditorInput.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 08.04.2021.
//

protocol CustomizableTextEditorViewModel: class {
    
    var output: TextEditorOutput? { get set }
    
    var text: String { get set }
    var maxTextLength: Int? { get set }
}
