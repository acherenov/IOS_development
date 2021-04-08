//
//  LoadingView.swift
//  MemeMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import UIKit

final class LoadingView: UIView {
    
    let logo = UIImageView()
    let logoMan = UIImageView()
    let hideLogoDuration: TimeInterval = 0.6

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    // MARK: - Public methods
    
    func hideLogo() {
        UIView.transition(with: logoMan,
                          duration: hideLogoDuration,
                          options: [.curveEaseIn]) { [ weak self ] in
            self?.logoMan.transform = .init(translationX: UIConstants.screenBounds.width * 0.8, y: 0)
        }
        
        UIView.transition(with: logo,
                          duration: hideLogoDuration,
                          options: .curveEaseIn) { [ weak self ] in
            self?.logo.transform = .init(translationX: UIConstants.screenBounds.width * -0.8, y: 0)
        }
    }

    // MARK: - Private methods
    
    private func setupView() {

        backgroundColor = R.color.main()
        
        addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        logo.image = R.image.launchLogo()
        
        addSubview(logoMan)
        logoMan.translatesAutoresizingMaskIntoConstraints = false
        logoMan.contentMode = .scaleAspectFit
        logoMan.image = R.image.launchLogoMan()
        
        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            logo.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            logoMan.rightAnchor.constraint(equalTo: rightAnchor),
            logoMan.bottomAnchor.constraint(equalTo: bottomAnchor),
            logoMan.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            logoMan.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)
        ])
    }
}
