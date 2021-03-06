//
//  MainAppRouter.swift
//  MemeMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import UIKit

class MainAppRouter: AppRouter {
    
    var window: UIWindow!
    
    private func openModule(_ controller: UIViewController) {
        createWindowIfNeeded()
        window.backgroundColor = R.color.backgroundDark()
        window.rootViewController = controller
        makeKeyAndVisibleIfNeeded()
    }
    
    private func createWindowIfNeeded() {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
    }
    
    private func makeKeyAndVisibleIfNeeded() {
        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }
    }
    
    func handleLaunch() {
        openLoadingModule()
    }
    
    func openLoadingModule() {
        let rootVC = UINavigationController()
        UIStyleManager.navigationControllerTransparent(rootVC)
        let vc = LoadingCoordinator.createModule()
        rootVC.show(vc, sender: nil)
        openModule(rootVC)
    }
}
