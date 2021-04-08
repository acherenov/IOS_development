//
//  TextEditorViewModelProtocol.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 08.04.2021.
//

protocol TextEditorViewModelProtocol: class {
    
    var text: String { get set }
    var maxTextLength: Int? { get }
    
    func save(_ editedText: String)
}
