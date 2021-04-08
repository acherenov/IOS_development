//
//  TemplatesViewController.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 03.04.2021.
//

import UIKit
import JGProgressHUD

final class TemplatesViewController: UIViewController {

    var viewModel: TemplatesViewModelProtocol!
    var coordinator: TemplatesCoordinatorProtocol!
    
    private let vibroGeneratorLight = UIImpactFeedbackGenerator(style: .light)
    
    private var _view: TemplatesView {
        return view as! TemplatesView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }

    override func loadView() {
        self.view = TemplatesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        navigationItem.title = R.string.localizable.appName()
        
        _view.settingsButton.addTarget(self, action: #selector(useOwnImage), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: _view.settingsButton)
        navigationItem.rightBarButtonItem = menuBarItem
        
        _view.memeTemplatesCollectionView.dataSource = self
        _view.memeTemplatesCollectionView.delegate = self
        _view.memeTemplatesCollectionView.register(MemeTemplateCollectionViewCell.self,
                                                   forCellWithReuseIdentifier: MemeTemplateCollectionViewCell.identifier)
        
    }
    
    @objc private func useOwnImage(sender: ButtonWithTouchSize) {
        sender.tapAnimation()
        vibroGeneratorLight.impactOccurred()
        viewModel.pickNewPhotoFromAssets { [ weak self ] asset in
            asset.loadOriginalImage { [ weak self ] result in
                guard let self = self
                else { return }
                
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.coordinator.showEditor(template: MemeTemplateLocal(image: data))
                    }
                case .failure:
                    DispatchQueue.main.async {
                        AlertManager.showErrorHUD(on: self.view)
                    }
                }
                
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension TemplatesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.templates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeTemplateCollectionViewCell.identifier, for: indexPath) as! MemeTemplateCollectionViewCell
        
        cell.setContent(viewModel.templates[indexPath.row])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TemplatesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.showEditor(template: viewModel.templates[indexPath.row])
    }
}

