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
    func shareButtonTapped(with content: UIImage, callback: @escaping (Bool) -> Void)
}


final class MainRouter_CN: MainRouterProtocol_CN {
    
    // MARK: - Dependencies
    
    private unowned var navigationContainer: UINavigationController
    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN
    
    
    // MARK: - Init
    
    init(navigationContainer: UINavigationController,
         repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN) {
        self.navigationContainer = navigationContainer
        self.repositoryDIContainer = repositoryDIContainer
    }
    
    
    // MARK: - Interface
    
    func menuButtonTapped() {
        let menuVC = MenuSceneConfigurator_CN.configure(navigationContainer: navigationContainer, repositoryDIContainer: repositoryDIContainer)
        navigationContainer.present(menuVC, animated: true, completion: nil)
    }
    
    func shareButtonTapped(with content: UIImage, callback: @escaping (Bool) -> Void) {
        let activityVC = UIActivityViewController(activityItems: [content],
                                                  applicationActivities: nil)
        activityVC.completionWithItemsHandler = { activity, success, items, error in
            callback(success)
            print("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
        }
        navigationContainer.present(activityVC, animated: true, completion: nil)
    }
    
    deinit {
        //        print("CN_MainRouter")
    }
}
