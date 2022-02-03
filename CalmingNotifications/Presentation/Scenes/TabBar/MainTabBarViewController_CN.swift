//
//  MainTabBarViewController_CN.swift
//  CalmingNotifications
//
//  Created by Max on 12.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


final class MainTabBarViewController_CN: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarVC()
        setupTabBarUI()
    }
    
    private func setupTabBarVC() {
        let mainVC = MainSceneConfigurator_CN.configure(navigationContainer: self)
        let notificationVC = NotificationSceneConfigurator_CN.configure(navigationContainer: self)
        mainVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        notificationVC.tabBarItem = UITabBarItem(title: nil,
                                                 image: UIImage(systemName: "bell"),
                                                 selectedImage: UIImage(systemName: "bell.fill"))
        viewControllers = [mainVC, notificationVC]
    }
    
    private func setupTabBarUI() {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
    
    
}
