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
    
    let addLabelButton = ButtonWithTouchSize()
    let scroll = UIScrollView()
    
    let noElementsSelectedLabel = UILabel()
    
    let menuSegment = LabelsSegmentedControl()
    let menuSelectionView = UIView()
    
    let textMenuContainer = UIView()
    
    let colorMenuContainer = UIView()

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
        textMenuContainer.isHidden = false
        colorMenuContainer.isHidden = false
        switch sender.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.textMenuContainer.alpha = 1
                self?.colorMenuContainer.alpha = 0
            }
        default:
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.textMenuContainer.alpha = 0
                self?.colorMenuContainer.alpha = 1
            }
        }
    }
    
    // MARK: - Public methods
    
    func manageNoContentLabelVisibility(visible: Bool, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.noElementsSelectedLabel.alpha = visible ? 1 : 0
                self?.menuSegment.alpha = visible ? 0 : 1
                self?.textMenuContainer.isHidden = !visible
                self?.colorMenuContainer.isHidden = !visible
            }
        } else {
            noElementsSelectedLabel.alpha = visible ? 1 : 0
            menuSegment.alpha = visible ? 0 : 1
            textMenuContainer.isHidden = !visible
            colorMenuContainer.isHidden = !visible
        }
    }

    // MARK: - Private methods
    
    private func setupView() {
        isUserInteractionEnabled = true
        backgroundColor = R.color.backgroundLight()
        
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

        setupMenu()
        setupTextMenu()
        setupColorMenu()
        
        manageNoContentLabelVisibility(visible: true, animated: false)

        makeConstraints()
    }
    
    private func setupMenu() {
        addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = R.color.tintColorLight()
        scroll.roundCorners(corners: [.topRight, .topLeft], radius: 40)
        
        addSubview(addLabelButton)
        addLabelButton.translatesAutoresizingMaskIntoConstraints = false
        addLabelButton.layer.cornerRadius = 28
        addLabelButton.setDefaultAreaPadding()
        addLabelButton.backgroundColor = R.color.backgroundLight()
        addLabelButton.layer.borderWidth = 5
        addLabelButton.layer.borderColor = R.color.tintColorLight()?.cgColor
        addLabelButton.setImage(R.image.plus(), for: .normal)
        addLabelButton.setImage(R.image.plus(), for: .selected)
        addLabelButton.tintColor = R.color.tintColorLight()
        
        scroll.addSubview(menuSegment)
        menuSegment.translatesAutoresizingMaskIntoConstraints = false
        menuSegment.backgroundColor = R.color.main()
        menuSegment.layer.cornerRadius = 30
        menuSegment.selectionView.backgroundColor = .clear
        menuSegment.addTextSegment(R.string.localizable.text())
        menuSegment.addTextSegment(R.string.localizable.color())
        menuSegment.addTarget(self, action: #selector(menuSegmentSelectionDidChanged(sender:)), for: .valueChanged)
        menuSegment.setSelectedSegmentIndex(0)
        
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
    }
    
    private func setupTextMenu() {
        scroll.addSubview(textMenuContainer)
        textMenuContainer.translatesAutoresizingMaskIntoConstraints = false
        textMenuContainer.backgroundColor = .clear
    }
    
    private func setupColorMenu() {
        scroll.addSubview(colorMenuContainer)
        colorMenuContainer.translatesAutoresizingMaskIntoConstraints = false
        colorMenuContainer.backgroundColor = .clear
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalToConstant: 18),
            saveButton.heightAnchor.constraint(equalToConstant: 18),
            
            imageContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            imageContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            imageContainer.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            scroll.centerXAnchor.constraint(equalTo: centerXAnchor),
            scroll.widthAnchor.constraint(equalTo: widthAnchor),
            scroll.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 40),
            scroll.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            noElementsSelectedLabel.heightAnchor.constraint(equalTo: scroll.heightAnchor, constant: -10),
            noElementsSelectedLabel.widthAnchor.constraint(equalTo: scroll.widthAnchor, multiplier: 0.6),
            noElementsSelectedLabel.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            noElementsSelectedLabel.centerYAnchor.constraint(equalTo: scroll.centerYAnchor),
            
            addLabelButton.centerYAnchor.constraint(equalTo: scroll.topAnchor, constant: 5),
            addLabelButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addLabelButton.widthAnchor.constraint(equalToConstant: 56),
            addLabelButton.heightAnchor.constraint(equalToConstant: 56),
            
            menuSegment.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 55),
            menuSegment.centerXAnchor.constraint(equalTo: centerXAnchor),
            menuSegment.heightAnchor.constraint(equalToConstant: 61),
            menuSegment.widthAnchor.constraint(equalTo: widthAnchor, constant: -66),
            
            menuSelectionView.heightAnchor.constraint(equalTo: menuSegment.selectionView.heightAnchor, constant: -10),
            menuSelectionView.widthAnchor.constraint(equalTo: menuSegment.selectionView.widthAnchor, constant: -10),
            menuSelectionView.centerXAnchor.constraint(equalTo: menuSegment.selectionView.centerXAnchor),
            menuSelectionView.centerYAnchor.constraint(equalTo: menuSegment.selectionView.centerYAnchor),
            
            textMenuContainer.topAnchor.constraint(equalTo: menuSegment.bottomAnchor, constant: 30),
            textMenuContainer.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -30),
            textMenuContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
            textMenuContainer.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            textMenuContainer.heightAnchor.constraint(equalToConstant: 500),
            
            colorMenuContainer.topAnchor.constraint(equalTo: menuSegment.bottomAnchor, constant: 30),
            colorMenuContainer.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -30),
            colorMenuContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
            colorMenuContainer.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            colorMenuContainer.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
}
