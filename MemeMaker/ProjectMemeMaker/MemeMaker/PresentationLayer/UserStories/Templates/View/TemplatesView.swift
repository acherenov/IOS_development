//
//  TemplatesView.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 03.04.2021.
//

import UIKit

final class TemplatesView: UIView {
    
    let sideMargin: CGFloat = 15
    
    let settingsButton = ButtonWithTouchSize()
    
    let memeTemplatesCollectionViewLayout = UICollectionViewFlowLayout()
    private(set) var memeTemplatesCollectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.backgroundLight()
        
        settingsButton.setImage(R.image.plus(), for: .normal)
        settingsButton.setImage(R.image.plus(), for: .selected)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setDefaultAreaPadding()
        settingsButton.tintColor = R.color.tintColorLight()
        
        memeTemplatesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: memeTemplatesCollectionViewLayout)
        addSubview(memeTemplatesCollectionView)
        memeTemplatesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        memeTemplatesCollectionView.backgroundColor = R.color.backgroundLight()
        memeTemplatesCollectionViewLayout.minimumLineSpacing = 15
        memeTemplatesCollectionViewLayout.scrollDirection = .vertical
        memeTemplatesCollectionViewLayout.itemSize = CGSize(width: MemeTemplateCollectionViewCell.sideSize,
                                                            height: MemeTemplateCollectionViewCell.sideSize)
        memeTemplatesCollectionView.contentInset = UIEdgeInsets(top: sideMargin,
                                                                left: sideMargin,
                                                                bottom: sideMargin,
                                                                right: sideMargin)
        
        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 18),
            settingsButton.heightAnchor.constraint(equalToConstant: 18),
            
            memeTemplatesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            memeTemplatesCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            memeTemplatesCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            memeTemplatesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
