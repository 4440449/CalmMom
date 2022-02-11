//
//  FavoritesRouter_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 08.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


protocol FavoritesRouterProtocol_CN {
    
}


final class FavoritesRouter_CN: FavoritesRouterProtocol_CN {
    
    // MARK: - Dependencies
    
    private unowned var navigationContainer: UIViewController
    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN

    
    // MARK: - Init
    
    init(navigationContainer: UIViewController,
         repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN) {
        self.navigationContainer = navigationContainer
        self.repositoryDIContainer = repositoryDIContainer
    }
    
    deinit {
        print("deinit FavoritesRouter_CN")
    }
    
}
