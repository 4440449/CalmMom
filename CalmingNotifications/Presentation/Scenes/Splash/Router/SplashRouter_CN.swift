//
//  SplashRouter_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 04.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation
import UIKit


protocol SplashRouterProtocol_CN {
//    func startMainFlow(quoteCards: [QuoteCard_CN])
    func startMainFlow()
}


final class SplashRouter_CN: SplashRouterProtocol_CN {
    
    // MARK: - Dependencies
    
    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN
    
    
    // MARK: - Init
    
    init(repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN) {
        self.repositoryDIContainer = repositoryDIContainer
    }
    
    
    // MARK: - Interface
    
    //    func startMainFlow(quoteCards: [QuoteCard_CN]) {
    func startMainFlow() {
        DispatchQueue.main.async {
//            let navigationContainer = UINavigationController()
//            navigationContainer.navigationBar.isHidden = true
//            let startVC = MainTabBarConfigurator_CN.configure(
//                quoteCards: quoteCards,
//                navigationContainer: navigationContainer,
//                repositoryDIContainer: self.repositoryDIContainer )
            guard let sceneDelegate =
                    UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
            guard let root = sceneDelegate.window?.rootViewController as? UINavigationController else { return }
            let startVC = MainSceneConfigurator_CN.configure(navigationContainer: root,
                                                             repositoryDIContainer: self.repositoryDIContainer)
            root.pushViewController(startVC, animated: true)
            root.viewControllers = [startVC]
//            let startVC = MainSceneConfigurator_CN.configure(
//                navigationContainer: navigationContainer,
//                repositoryDIContainer: self.repositoryDIContainer)
//            if let sceneDelegate =
//                UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//                let root = sceneDelegate.window?.rootViewController
//                guard let root = root as? UINavigationController else { return }
//                root.viewControllers = [startVC]
//                root.pushViewController(startVC, animated: true)
//            }
//            navigationContainer.viewControllers = [startVC]
            
//            if let sceneDelegate =
//                UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//                sceneDelegate.window?.rootViewController = navigationContainer
//                sceneDelegate.window?.makeKeyAndVisible() // надо?
//            }
        }
    }
    
    deinit {
        //        print("SplashRouter_CN is deinit -------- ")
    }
    
}
