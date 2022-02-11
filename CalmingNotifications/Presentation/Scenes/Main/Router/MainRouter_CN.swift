//
//  MainRouter_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


protocol MainRouterProtocol_CN {
    func menuButtonTapped()
    func shareButtonTapped(with content: UIImage)
}


final class MainRouter_CN: MainRouterProtocol_CN {
    
    // MARK: - Dependencies
    
    private unowned var navigationContainer: UIViewController
    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN
    
    
    // MARK: - Init
    
    init(navigationContainer: UIViewController,
         repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN) {
        self.navigationContainer = navigationContainer
        self.repositoryDIContainer = repositoryDIContainer
    }
    
    
    // MARK: - Interface
    
    func menuButtonTapped() {
        let menuVC = MenuSceneConfigurator_CN.configure(navigationContainer: navigationContainer, repositoryDIContainer: repositoryDIContainer)
        navigationContainer.present(menuVC, animated: true, completion: nil)
//        let favoritesVC = FavoritesSceneConfigurator_CN.configure(navigationContainer: navContainer, repositoryDIContainer: repositoryDIContainer)
//        navContainer.present(favoritesVC, animated: true, completion: nil)
    }
    
    func shareButtonTapped(with content: UIImage) {
        let activityVC = UIActivityViewController(activityItems: [content],
                                                  applicationActivities: nil)
        navigationContainer.show(activityVC, sender: nil)
    }
    
    deinit {
        print("CN_MainRouter")
    }
}
