//
//  DragableLabel.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 07.04.2021.
//

import UIKit

protocol DragableLabelDelegate: class {
    
    func labelDidTapped(_ label: DragableLabel)
    func labelStartDragging(_ label: DragableLabel)
    func labelEndDragging(_ label: DragableLabel)
}

class DragableLabel: UILabel {
    
    weak var delegate: DragableLabelDelegate?
    
    let selectionView = UIView()
    
    private(set) var isSelected: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public methods
    
    func toggleSelection() {
        manageSelection(selected: !isSelected)
    }
    
    func manageSelection(selected: Bool, animated: Bool = true) {
        isSelected = selected
        if animated {
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.selectionView.alpha = selected ? 1 : 0
            }
        } else {
            selectionView.alpha = selected ? 1 : 0
        }
    }
    
    // MARK: - UI elements actions
    
    @objc private func handleTap(recognizer: UITapGestureRecognizer) {
        delegate?.labelDidTapped(self)
    }

    @objc private func handlePan(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            delegate?.labelStartDragging(self)
        }
        if recognizer.state == .ended {
            delegate?.labelEndDragging(self)
        }
        
        guard let superview = superview
        else { return }
        let touch = recognizer.location(in: superview)
        let superviewCenter = CGPoint(x: superview.center.x - superview.frame.origin.x,
                                      y: superview.center.y - superview.frame.origin.y)
        let touchRelativePoint = CGPoint(x: touch.x - superviewCenter.x, y: touch.y - superviewCenter.y)
        let x = touchRelativePoint.x
        let y = touchRelativePoint.y
        UIView.animate(withDuration: 0.1) { [ weak self ] in
            self?.center = CGPoint(x: x + superviewCenter.x, y: y + superviewCenter.y)
        }
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        isUserInteractionEnabled = true

        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        addGestureRecognizer(longPressRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        addGestureRecognizer(tapRecognizer)
        
        addSubview(selectionView)
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        selectionView.isUserInteractionEnabled = false
        selectionView.alpha = 0
        selectionView.layer.borderWidth = 2
        selectionView.layer.borderColor = R.color.stringSelectionColor()?.cgColor

        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            selectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectionView.widthAnchor.constraint(equalTo: widthAnchor, constant: 10),
            selectionView.heightAnchor.constraint(equalTo: heightAnchor, constant: 10)
        ])
    }
}
