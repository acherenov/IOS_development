//
//  TextEditorViewController.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 08.04.2021.
//

import UIKit

final class TextEditorViewController: UIViewController {

    var viewModel: TextEditorViewModelProtocol!
    var coordinator: TextEditorCoordinatorProtocol!
    
    private var _view: TextEditorView {
        return view as! TextEditorView
    }

    override func loadView() {
        self.view = TextEditorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        addTapGestureToHideKeyboard()
        
        let saveButton = UIBarButtonItem(title: R.string.localizable.save(),
                                         style: .done,
                                         target: self,
                                         action: #selector(save))
        saveButton.setTitleTextAttributes([NSAttributedString.Key.font: R.font.gilroyBold(size: 14)!,
                                           NSAttributedString.Key.foregroundColor: R.color.tintColorLight()!],
                                          for: .normal)
        saveButton.setTitleTextAttributes([NSAttributedString.Key.font: R.font.gilroyBold(size: 14)!,
                                           NSAttributedString.Key.foregroundColor: R.color.tintColorLight()!],
                                          for: .selected)
        navigationItem.rightBarButtonItem = saveButton
                
        if let maxLength = viewModel.maxTextLength {
            _view.editor.maxLength = maxLength
        }
        _view.editor.text = viewModel.text
        view.layoutIfNeeded()
        
        _view.editor.textEditor.becomeFirstResponder()
    }
    
    // MARK: - UI elements actions
    
    @objc private func backButtonTapped() {
        coordinator.dismiss()
    }
    
    @objc private func save() {
        viewModel.save(_view.editor.text)
        coordinator.dismiss()
    }
}
