//
//  MemeTemplateCollectionViewCell.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 04.04.2021.
//

import UIKit

class MemeTemplateCollectionViewCell: UICollectionViewCell {
    
    static let sideSize: CGFloat = (UIConstants.screenBounds.width - 45) / 2
    
    let imageContainer = FitImageContainer()
    
    var sideSize: CGFloat {
        return MemeTemplateCollectionViewCell.sideSize
    }
    
    static var identifier: String {
        String(describing: self)
    }
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public methods
    
    func setContent(_ content: MemeTemplate) {
        imageContainer.setImage(template: content)
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        backgroundColor = .clear
        layer.masksToBounds = true
        layer.cornerRadius = sideSize * 0.2
        
        addSubview(imageContainer)
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
                
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            imageContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: sideSize),
            imageContainer.heightAnchor.constraint(equalToConstant: sideSize)
        ])
    }
}

