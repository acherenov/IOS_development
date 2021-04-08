//
//  EditorViewController.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 05.04.2021.
//

import UIKit

final class EditorViewController: UIViewController {

    var viewModel: EditorViewModelProtocol!
    var coordinator: EditorCoordinatorProtocol!
    
    private let vibroGeneratorLight = UIImpactFeedbackGenerator(style: .light)
    private var selectedLabels = [DragableLabel]() {
        didSet {
            _view.manageNoContentLabelVisibility(visible: selectedLabels.isEmpty)
        }
    }
    
    private var _view: EditorView {
        return view as! EditorView
    }

    override func loadView() {
        self.view = EditorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        navigationItem.title = R.string.localizable.editor()
        _view.imageContainer.setImage(template: viewModel.template)
        
        let menuBarItem = UIBarButtonItem(customView: _view.saveButton)
        navigationItem.rightBarButtonItem = menuBarItem
        _view.saveButton.addTarget(self, action: #selector(saveButtonDidTapped(sender:)), for: .touchUpInside)
        
        _view.addLabelButton.addTarget(self, action: #selector(addBottonDidTapped(sender:)), for: .touchUpInside)
    }
    
    // MARK: - UI elements actions
    
    @objc private func saveButtonDidTapped(sender: ButtonWithTouchSize) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
        
        let result = _view.imageContainer.imageView.snapshot()
        UIImageWriteToSavedPhotosAlbum(result, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func addBottonDidTapped(sender: ButtonWithTouchSize) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
        let label = DragableLabel(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        label.text = "sdfsadfadf sad sd sad sd\nasdfsadf"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.delegate = self
        _view.imageContainer.imageView.addSubview(label)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            AlertManager.showErrorHUD(on: _view.imageContainer)
            print("ERROR: \(error)")
        }
        else {
            AlertManager.showSuccessHUD(on: _view.imageContainer)
        }
    }
}

// MARK: - DragableLabelDelegate

extension EditorViewController: DragableLabelDelegate {
    
    func labelDidTapped(_ label: DragableLabel) {
        label.toggleSelection()
        vibroGeneratorLight.impactOccurred()
        if label.isSelected {
            if !selectedLabels.contains(label) {
                selectedLabels.append(label)
            }
        } else {
            selectedLabels.removeAll { $0.isSelected == false }
        }
    }
    
    func labelStartDragging(_ label: DragableLabel) {
        vibroGeneratorLight.impactOccurred()
    }
    
    func labelEndDragging(_ label: DragableLabel) {
        
    }
}
