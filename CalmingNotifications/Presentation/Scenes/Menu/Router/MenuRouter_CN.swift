//
//  MenuRouter_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


protocol MenuRouterProtocol_CN {
    func didSelect(item: MenuItem)
}


final class MenuRouter_CN: MenuRouterProtocol_CN {
  
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
    
    func didSelect(item: MenuItem) {
//        guard let nav = navigationContainer as? UINavigationController else { return }
//        nav.viewControllers.forEach {
//            if let vc = $0 as? MenuViewController_CN {
//                vc.dismiss(animated: true, completion: nil)
//            }
//        }
        
        switch item.title {
        case .favorites:
            let favoritesVC = FavoritesSceneConfigurator_CN.configure(
                navigationContainer: navigationContainer,
                repositoryDIContainer: repositoryDIContainer )
            favoritesVC.modalPresentationStyle = .overFullScreen
            navigationContainer.show(favoritesVC, sender: nil)
            
            
            
        }
    }

}
