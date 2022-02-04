//
//  MainRouter_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


protocol MainRouterProtocol_CN {
    func move()
    func showActivity(with content: UIImage)
}

final class MainRouter_CN: MainRouterProtocol_CN {
    
    // MARK: - Dependencies

    private weak var navigationContainer: UIViewController?
    
    init(navigationContainer: UIViewController) {
        self.navigationContainer = navigationContainer
    }
    
    
    // MARK: - Interface

    func move() {
        guard let navContainer = navigationContainer as? UITabBarController else {
            return
        }
        navContainer.show(MenuSceneConfigurator_CN.configure(navigationContainer: navContainer), sender: nil)
    }
    
    func showActivity(with content: UIImage) {
        guard let navContainer = navigationContainer as? UITabBarController else {
            return
        }
        let activityVC = UIActivityViewController(activityItems: [content],
                                                applicationActivities: nil)
        navContainer.show(activityVC, sender: nil)
    }
    
    deinit {
        print("CN_MainRouter")
    }
}
