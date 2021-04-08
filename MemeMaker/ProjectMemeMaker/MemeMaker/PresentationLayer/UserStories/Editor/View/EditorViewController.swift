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
    private var selectedLabels = [DragableLabelView]() {
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
        
        _view.addLabelButton.addTarget(self, action: #selector(addButtonDidTapped(sender:)), for: .touchUpInside)
        _view.removeLabelButton.addTarget(self, action: #selector(removeButtonDidTapped(sender:)), for: .touchUpInside)
        _view.editLabelButton.addTarget(self, action: #selector(editButtonDidTapped(sender:)), for: .touchUpInside)
        
        _view.textMenuContainer.textAlignmentButtonLeft.addTarget(self, action: #selector(alignmentButtonDidTapped(sender:)), for: .touchUpInside)
        _view.textMenuContainer.textAlignmentButtonCenter.addTarget(self, action: #selector(alignmentButtonDidTapped(sender:)), for: .touchUpInside)
        _view.textMenuContainer.textAlignmentButtonRight.addTarget(self, action: #selector(alignmentButtonDidTapped(sender:)), for: .touchUpInside)
        _view.textMenuContainer.selectFontButton.addTarget(self, action: #selector(fontButtonDidTapped(sender:)), for: .touchUpInside)
        _view.textMenuContainer.fontSizeSlider.addTarget(self, action: #selector(fontSizeSliderValueChanged(sender:)), for: .valueChanged)
        
        _view.colorMenuContainer.fontColorButton.addTarget(self, action: #selector(colorButtonDidTapped(sender:)), for: .touchUpInside)
        _view.colorMenuContainer.backgroundColorButton.addTarget(self, action: #selector(colorButtonDidTapped(sender:)), for: .touchUpInside)
        
        _view.shapeMenuContainer.widthSlider.addTarget(self, action: #selector(shapeSliderValueChanged(sender:)), for: .valueChanged)
        _view.shapeMenuContainer.heightSlider.addTarget(self, action: #selector(shapeSliderValueChanged(sender:)), for: .valueChanged)
        _view.shapeMenuContainer.cornerRadiusSlider.addTarget(self, action: #selector(shapeSliderValueChanged(sender:)), for: .valueChanged)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [ weak self ] in
            guard let self = self
            else { return }
            let imageFrame = self._view.imageContainer.imageView.frame
            self._view.shapeMenuContainer.widthSlider.maximumValue = Float(imageFrame.width)
            self._view.shapeMenuContainer.heightSlider.maximumValue = Float(imageFrame.height)
        }
    }
    
    // MARK: - UI elements actions
    
    @objc private func saveButtonDidTapped(sender: ButtonWithTouchSize) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
        
        selectedLabels.forEach { $0.manageSelection(selected: false, animated: false) }
        
        let result = _view.imageContainer.imageView.snapshot()
        UIImageWriteToSavedPhotosAlbum(result, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        selectedLabels.forEach { $0.manageSelection(selected: true, animated: false) }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            AlertManager.showErrorHUD(on: _view)
            print("ERROR: \(error)")
        }
        else {
            AlertManager.showSuccessHUD(on: _view, withText: R.string.localizable.saveImageSuccessText())
        }
    }
    
    // MARK: - Menu top buttons
    
    @objc private func addButtonDidTapped(sender: ButtonWithTouchSize) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
        
        let labelView = DragableLabelView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        labelView.label.font = R.font.gilroySemibold(size: 20)
        labelView.label.text = R.string.localizable.sampleText()
        labelView.label.textAlignment = .center
        labelView.label.numberOfLines = 0
        labelView.delegate = self
        labelView.center = CGPoint(x: _view.imageContainer.imageView.frame.width / 2,
                                   y: _view.imageContainer.imageView.frame.height / 2)
        _view.imageContainer.imageView.addSubview(labelView)
        
        labelDidTapped(labelView)
    }
    
    @objc private func removeButtonDidTapped(sender: ButtonWithTouchSize) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
        
        selectedLabels.forEach { $0.removeFromSuperview() }
        selectedLabels.removeAll()
    }
    
    // MARK: - Text options
    
    @objc private func alignmentButtonDidTapped(sender: ButtonWithTouchSize) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
        
        var alignment = NSTextAlignment.center
        switch sender {
        case _view.textMenuContainer.textAlignmentButtonLeft:
            alignment = .left
        case _view.textMenuContainer.textAlignmentButtonRight:
            alignment = .right
        case _view.textMenuContainer.textAlignmentButtonCenter:
            alignment = .center
        default:
            break
        }
        
        selectedLabels.forEach { $0.label.textAlignment = alignment }
    }
    
    @objc private func fontButtonDidTapped(sender: ButtonWithTouchSize) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
        let vc = UIFontPickerViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc private func editButtonDidTapped(sender: ButtonWithTouchSize) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
        
        guard selectedLabels.count == 1
        else {
        AlertManager.showErrorHUD(on: view,
                                  withText: R.string.localizable.error(),
                                  detailText: R.string.localizable.needsOnlyOneLabelErrorText(),
                                  delegate: nil)
            return
        }
        
        coordinator.showTextEditor(startText: selectedLabels.first?.label.text ?? "", output: self)
    }
    
    @objc private func fontSizeSliderValueChanged(sender: UISlider) {
        selectedLabels.forEach {
            $0.label.font = $0.label.font.withSize(CGFloat(sender.value))
        }
    }
    
    // MARK: - Color options
    
    @objc private func colorButtonDidTapped(sender: ButtonWithTouchSize) {
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
        
        switch sender {
        case _view.colorMenuContainer.fontColorButton:
            showAlertWithColorPicker(startColor: selectedLabels.last?.label.textColor) { [ weak self ] color in
                self?.selectedLabels.forEach {
                    $0.label.textColor = color
                }
            }
        case _view.colorMenuContainer.backgroundColorButton:
            showAlertWithColorPicker(startColor: selectedLabels.last?.backgroundColor) { [ weak self ] color in
                self?.selectedLabels.forEach {
                    $0.backgroundColor = color
                }
            }
        default:
            break
        }
    }
    
    // MARK: - Shape options
    
    @objc private func shapeSliderValueChanged(sender: UISlider) {
        switch sender {
        case _view.shapeMenuContainer.heightSlider:
            selectedLabels.forEach {
                $0.frame.size.height = CGFloat(sender.value)
            }
        case _view.shapeMenuContainer.widthSlider:
            selectedLabels.forEach {
                $0.frame.size.width = CGFloat(sender.value)
            }
        case _view.shapeMenuContainer.cornerRadiusSlider:
            selectedLabels.forEach {
                $0.layer.cornerRadius = CGFloat(sender.value)
            }
        default:
            break
        }
    }

}

// MARK: - DragableLabelDelegate

extension EditorViewController: DragableLabelDelegate {
    
    func labelDidTapped(_ labelView: DragableLabelView) {
        labelView.toggleSelection()
        vibroGeneratorLight.impactOccurred()
        if labelView.isSelected {
            if !selectedLabels.contains(labelView) {
                selectedLabels.append(labelView)
                
                _view.textMenuContainer.fontSizeSlider.value = Float(labelView.label.font.pointSize)
                _view.shapeMenuContainer.heightSlider.value = Float(labelView.frame.size.height)
                _view.shapeMenuContainer.widthSlider.value = Float(labelView.frame.size.width)
                _view.shapeMenuContainer.cornerRadiusSlider.value = Float(labelView.layer.cornerRadius)
            }
        } else {
            selectedLabels.removeAll { $0.isSelected == false }
        }
    }
    
    func labelStartDragging(_ label: DragableLabelView) {
        vibroGeneratorLight.impactOccurred()
    }
    
    func labelEndDragging(_ label: DragableLabelView) {
        
    }
}

// MARK: - TextEditorOutput

extension EditorViewController: TextEditorOutput {
    
    func returnEditedText(_ text: String) {
        selectedLabels.first?.label.text = text
    }
}

// MARK: - UIFontPickerViewControllerDelegate

extension EditorViewController: UIFontPickerViewControllerDelegate {
    
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        guard let descriptor = viewController.selectedFontDescriptor
        else { return }

        let font = UIFont(descriptor: descriptor, size: CGFloat(_view.textMenuContainer.fontSizeSlider.value))
        selectedLabels.forEach {
            $0.label.font = font.withSize($0.label.font.pointSize)
        }
    }
}
