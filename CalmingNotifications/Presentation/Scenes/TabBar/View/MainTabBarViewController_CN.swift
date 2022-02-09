//
//  MainTabBarViewController_CN.swift
//  CalmingNotifications
//
//  Created by Max on 12.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


final class MainTabBarViewController_CN: UITabBarController {
    
    // MARK: - Dependencies

//    private let quoteCards: [QuoteCard_CN]
    
    
    // MARK: - Init
    
//    init(
////        quoteCards: [QuoteCard_CN],
//                  nibName nibNameOrNil: String?,
//                  bundle nibBundleOrNil: Bundle?) {
////        self.quoteCards = quoteCards
//        super.init(nibName: nibNameOrNil,
//                   bundle: nibBundleOrNil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    // MARK: - View's lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTabBarVC()
        setupTabBarUI()
    }
    
    
    // MARK: - Private setup

    func setupTabBarVC(quoteCards: [QuoteCard_CN],
                       quotes: [String],
                       repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN) {
        let mainVC = MainSceneConfigurator_CN.configure(navigationContainer: self,
                                                        repositoryDIContainer: repositoryDIContainer,
                                                        quoteCards: quoteCards)
        let notificationVC = NotificationSceneConfigurator_CN.configure(navigationContainer: self,
                                                       repositoryDIContainer: repositoryDIContainer,
                                                       quotes: quotes)
        mainVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        notificationVC.tabBarItem = UITabBarItem(title: nil,
                                                 image: UIImage(systemName: "bell"),
                                                 selectedImage: UIImage(systemName: "bell.fill"))
        viewControllers = [mainVC, notificationVC]
    }
    
    
    // MARK: - UI -
    
    private func setupTabBarUI() {
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
    
    
}
