//
//  MainRouterProtocol_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


protocol MainRouterProtocol_CN {
    
    func move()
}

final class CN_MainRouter: MainRouterProtocol_CN {
    
    private let navigationContainer: UIViewController
    
    init(navigationContainer: UIViewController) {
        self.navigationContainer = navigationContainer
    }
    
    func move() {
        guard let navContainer = navigationContainer as? UITabBarController else {
            return
        }
        navContainer.show(MenuSceneConfigurator_CN.configure(navigationContainer: navContainer), sender: nil)
    }
}
