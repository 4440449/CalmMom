//
//  FavoritesRouter_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 08.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


protocol FavoritesRouterProtocol_CN {
    func dismissButtonTapped()
}


final class FavoritesRouter_CN: FavoritesRouterProtocol_CN {
    
    // MARK: - Dependencies
    
    private unowned var navigationContainer: UINavigationController
    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN

    
    // MARK: - Init
    
    init(navigationContainer: UINavigationController,
         repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN) {
        self.navigationContainer = navigationContainer
        self.repositoryDIContainer = repositoryDIContainer
    }
    
    func dismissButtonTapped() {
        
    }
    
    deinit {
//        print("deinit FavoritesRouter_CN")
    }
    
}
