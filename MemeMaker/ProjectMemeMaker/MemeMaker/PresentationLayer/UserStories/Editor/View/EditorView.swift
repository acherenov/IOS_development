//
//  EditorView.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 05.04.2021.
//

import UIKit

final class EditorView: UIView {
    
    let saveButton = ButtonWithTouchSize()
    
    let imageContainer = FitImageContainer()
    
    let removeLabelButton = ButtonWithTouchSize()
    let editLabelButton = ButtonWithTouchSize()
    let addLabelButton = ButtonWithTouchSize()
    let scroll = UIScrollView()
    
    let noElementsSelectedLabel = UILabel()
    
    let editorContentView = UIView()
    let menuSegment = LabelsSegmentedControl()
    let menuSelectionView = UIView()
    
    let textMenuContainer = TextOptionsView()
    let colorMenuContainer = ColorOptionsView()
    let shapeMenuContainer = ShapeOptionsView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    // MARK: - UI elements actions

    @objc private func menuSegmentSelectionDidChanged(sender: LabelsSegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.textMenuContainer.alpha = 1
                self?.colorMenuContainer.alpha = 0
                self?.shapeMenuContainer.alpha = 0
            }
        case 1:
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.textMenuContainer.alpha = 0
                self?.colorMenuContainer.alpha = 1
                self?.shapeMenuContainer.alpha = 0
            }
        default:
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.textMenuContainer.alpha = 0
                self?.colorMenuContainer.alpha = 0
                self?.shapeMenuContainer.alpha = 1
            }
        }
    }
    
    // MARK: - Public methods
    
    func manageNoContentLabelVisibility(visible: Bool, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.noElementsSelectedLabel.alpha = visible ? 1 : 0
                self?.editorContentView.alpha = visible ? 0 : 1
                self?.scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
            }
        } else {
            noElementsSelectedLabel.alpha = visible ? 1 : 0
            editorContentView.alpha = visible ? 0 : 1
            scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
        }
    }

    // MARK: - Private methods
    
    private func setupView() {
        isUserInteractionEnabled = true
        backgroundColor = R.color.backgroundLight()
        
        setupScreenTopViews()
        setupMenu()
        
        manageNoContentLabelVisibility(visible: true, animated: false)

        makeConstraints()
        makeEditorContentViewConstraints()
    }
    
    private func setupScreenTopViews() {
        saveButton.setImage(R.image.save(), for: .normal)
        saveButton.setImage(R.image.save(), for: .selected)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setDefaultAreaPadding()
        saveButton.tintColor = R.color.tintColorLight()
        
        addSubview(imageContainer)
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.layer.cornerRadius = 30
        imageContainer.isUserInteractionEnabled = true
        imageContainer.imageView.isUserInteractionEnabled = true
        imageContainer.imageView.layer.masksToBounds = true
    }
    
    private func setupMenu() {
        addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = R.color.tintColorLight()
        scroll.roundCorners(corners: [.topRight, .topLeft], radius: 40)
        scroll.showsVerticalScrollIndicator = false
        
        setupRoundButton(addLabelButton, image: R.image.plus())
        setupRoundButton(editLabelButton, image: R.image.edit())
        setupRoundButton(removeLabelButton, image: R.image.remove())

        scroll.addSubview(editorContentView)
        editorContentView.translatesAutoresizingMaskIntoConstraints = false
        editorContentView.backgroundColor = R.color.tintColorLight()
        
        editorContentView.addSubview(menuSegment)
        menuSegment.translatesAutoresizingMaskIntoConstraints = false
        menuSegment.backgroundColor = R.color.main()
        menuSegment.layer.cornerRadius = 30
        menuSegment.selectionView.backgroundColor = .clear
        menuSegment.addTextSegment(R.string.localizable.text())
        menuSegment.addTextSegment(R.string.localizable.color())
        menuSegment.addTextSegment(R.string.localizable.size())
        menuSegment.addTarget(self, action: #selector(menuSegmentSelectionDidChanged(sender:)), for: .valueChanged)
        menuSegment.setSelectedSegmentIndex(0)
        menuSegmentSelectionDidChanged(sender: menuSegment)
        
        menuSegment.selectionView.addSubview(menuSelectionView)
        menuSelectionView.translatesAutoresizingMaskIntoConstraints = false
        menuSelectionView.backgroundColor = R.color.tintColorLight()
        menuSelectionView.layer.cornerRadius = 25
        
        addSubview(noElementsSelectedLabel)
        noElementsSelectedLabel.translatesAutoresizingMaskIntoConstraints = false
        noElementsSelectedLabel.textColor = R.color.main()
        noElementsSelectedLabel.font = R.font.gilroyBold(size: 32)
        noElementsSelectedLabel.numberOfLines = 0
        noElementsSelectedLabel.text = R.string.localizable.noElementsSelected()
        noElementsSelectedLabel.textAlignment = .center
        
        editorContentView.addSubview(textMenuContainer)
        textMenuContainer.translatesAutoresizingMaskIntoConstraints = false
        
        editorContentView.addSubview(colorMenuContainer)
        colorMenuContainer.translatesAutoresizingMaskIntoConstraints = false
        
        editorContentView.addSubview(shapeMenuContainer)
        shapeMenuContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupRoundButton(_ button: ButtonWithTouchSize, image: UIImage?) {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 28
        button.setDefaultAreaPadding()
        button.backgroundColor = R.color.backgroundLight()
        button.layer.borderWidth = 5
        button.layer.borderColor = R.color.tintColorLight()?.cgColor
        button.setImage(image, for: .normal)
        button.setImage(image, for: .selected)
        button.setImage(image, for: .highlighted)
        button.tintColor = R.color.tintColorLight()
    }
    
    private func setupTextMenu() {
        
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalToConstant: 18),
            saveButton.heightAnchor.constraint(equalToConstant: 18),
            
            imageContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            imageContainer.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            scroll.centerXAnchor.constraint(equalTo: centerXAnchor),
            scroll.widthAnchor.constraint(equalTo: widthAnchor),
            scroll.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 30),
            scroll.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            noElementsSelectedLabel.heightAnchor.constraint(equalTo: scroll.heightAnchor, multiplier: 0.7),
            noElementsSelectedLabel.widthAnchor.constraint(equalTo: scroll.widthAnchor, multiplier: 0.6),
            noElementsSelectedLabel.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            noElementsSelectedLabel.topAnchor.constraint(equalTo: scroll.topAnchor),

            addLabelButton.centerYAnchor.constraint(equalTo: scroll.topAnchor, constant: 5),
            addLabelButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addLabelButton.widthAnchor.constraint(equalToConstant: 56),
            addLabelButton.heightAnchor.constraint(equalToConstant: 56),
            
            editLabelButton.centerYAnchor.constraint(equalTo: addLabelButton.centerYAnchor),
            editLabelButton.rightAnchor.constraint(equalTo: addLabelButton.leftAnchor, constant: -15),
            editLabelButton.widthAnchor.constraint(equalTo: addLabelButton.widthAnchor),
            editLabelButton.heightAnchor.constraint(equalTo: addLabelButton.heightAnchor),
            
            removeLabelButton.centerYAnchor.constraint(equalTo: addLabelButton.centerYAnchor),
            removeLabelButton.leftAnchor.constraint(equalTo: addLabelButton.rightAnchor, constant: 15),
            removeLabelButton.widthAnchor.constraint(equalTo: addLabelButton.widthAnchor),
            removeLabelButton.heightAnchor.constraint(equalTo: addLabelButton.heightAnchor)
        ])
    }
    
    private func makeEditorContentViewConstraints() {
        NSLayoutConstraint.activate([
            editorContentView.topAnchor.constraint(equalTo: scroll.topAnchor),
            editorContentView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            editorContentView.widthAnchor.constraint(equalTo: widthAnchor, constant: -10),
            editorContentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            menuSegment.topAnchor.constraint(equalTo: editorContentView.topAnchor, constant: 50),
            menuSegment.centerXAnchor.constraint(equalTo: centerXAnchor),
            menuSegment.heightAnchor.constraint(equalToConstant: 61),
            menuSegment.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            menuSelectionView.heightAnchor.constraint(equalTo: menuSegment.selectionView.heightAnchor, constant: -10),
            menuSelectionView.widthAnchor.constraint(equalTo: menuSegment.selectionView.widthAnchor, constant: -10),
            menuSelectionView.centerXAnchor.constraint(equalTo: menuSegment.selectionView.centerXAnchor),
            menuSelectionView.centerYAnchor.constraint(equalTo: menuSegment.selectionView.centerYAnchor),
            
            textMenuContainer.topAnchor.constraint(equalTo: menuSegment.bottomAnchor, constant: 30),
            textMenuContainer.bottomAnchor.constraint(lessThanOrEqualTo: editorContentView.bottomAnchor, constant: -30),
            textMenuContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
            textMenuContainer.centerXAnchor.constraint(equalTo: editorContentView.centerXAnchor),
            
            colorMenuContainer.topAnchor.constraint(equalTo: menuSegment.bottomAnchor, constant: 30),
            colorMenuContainer.bottomAnchor.constraint(lessThanOrEqualTo: editorContentView.bottomAnchor, constant: -30),
            colorMenuContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
            colorMenuContainer.centerXAnchor.constraint(equalTo: editorContentView.centerXAnchor),
            
            shapeMenuContainer.topAnchor.constraint(equalTo: menuSegment.bottomAnchor, constant: 30),
            shapeMenuContainer.bottomAnchor.constraint(lessThanOrEqualTo: editorContentView.bottomAnchor, constant: -30),
            shapeMenuContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
            shapeMenuContainer.centerXAnchor.constraint(equalTo: editorContentView.centerXAnchor)
        ])
    }
}
