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
    
    private weak var navigationContainer: UIViewController?
    
    
    // MARK: - Init
    
    init(navigationContainer: UIViewController) {
        self.navigationContainer = navigationContainer
    }
    
    deinit {
        print("deinit FavoritesRouter_CN")
    }
    
}
