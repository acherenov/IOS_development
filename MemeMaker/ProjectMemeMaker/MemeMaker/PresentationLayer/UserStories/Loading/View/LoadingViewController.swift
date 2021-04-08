//
//  LoadingViewController.swift
//  MemeMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    var viewModel: LoadingViewModelProtocol!
    var coordinator: LoadingCoordinatorProtocol!
    
    private var _view: LoadingView {
        return view as! LoadingView
    }
    
    override func loadView() {
        self.view = LoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSelf()
    }
    
    private func configureSelf() {
        viewModel.startConfiguration()
        
        UIStyleManager.setUIBarButtonItemsClear()
        navigationController?.navigationBar.barStyle = .black
        
        _view.hideLogo()
        DispatchQueue.main.asyncAfter(deadline: .now() + _view.hideLogoDuration * 0.9) { [ weak self ] in
            self?.coordinator.showTemplates()
        }
    }
}
