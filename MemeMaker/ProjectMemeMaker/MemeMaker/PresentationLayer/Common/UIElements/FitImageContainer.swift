//
//  FitImageContainer.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 04.04.2021.
//

import UIKit

class FitImageContainer: UIView {
    
    private var imageViewWidth: NSLayoutConstraint!
    private var imageViewHeight: NSLayoutConstraint!
    
    let backgroundImageView = UIImageView()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public methods
    
    func setImage(template: MemeTemplate, animated: Bool = false) {
        imageView.image = nil
        if animated {
            imageView.sd_imageIndicator?.startAnimatingIndicator()
        }
        template.loadImage { [ weak self ] image in
            self?.imageView.sd_imageIndicator?.stopAnimatingIndicator()
            self?.setImage(image: image, animated: animated)
        }
    }
    
    func setImage(image: UIImage?, animated: Bool = true) {
        // needed to convert view to image correctly
        if let imageSize = image?.size {
            NSLayoutConstraint.deactivate([
                imageViewWidth,
                imageViewHeight
            ])
            imageViewWidth = imageView.widthAnchor.constraint(equalTo: widthAnchor)
            imageViewHeight = imageView.heightAnchor.constraint(equalTo: heightAnchor)
            if imageSize.width > imageSize.height {
                imageViewWidth = imageView.widthAnchor.constraint(equalTo: widthAnchor)
                imageViewHeight = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: imageSize.height / imageSize.width)
            } else {
                imageViewHeight = imageView.heightAnchor.constraint(equalTo: heightAnchor)
                imageViewWidth = imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: imageSize.width / imageSize.height)
            }
            NSLayoutConstraint.activate([
                imageViewWidth,
                imageViewHeight
            ])
        }
        
        if animated {
            UIView.transition(with: self.imageView,
                              duration: 0.5,
                              options: [.transitionCrossDissolve]) { [ weak self ] in
                self?.imageView.image = image
            }
            UIView.transition(with: self.backgroundImageView,
                              duration: 1,
                              options: [.transitionCrossDissolve]) { [ weak self ] in
                self?.backgroundImageView.image = image
            }
        } else {
            imageView.image = image
            backgroundImageView.image = image
        }
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        layer.masksToBounds = true
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setDefaultLoadingInicator()
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        imageViewWidth = imageView.widthAnchor.constraint(equalTo: widthAnchor)
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: heightAnchor)
        NSLayoutConstraint.activate([
            backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor),
            
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageViewWidth,
            imageViewHeight
        ])
    }
}
