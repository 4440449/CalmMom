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
    
    private weak var view: UIViewController?
    private unowned var navigationContainer: UINavigationController
    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN
    
    
    // MARK: - Init
    
    init(view: UIViewController? = nil,
         navigationContainer: UINavigationController,
         repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN) {
        self.view = view
        self.navigationContainer = navigationContainer
        self.repositoryDIContainer = repositoryDIContainer
    }
    
    func injectView(_ view: UIViewController) {
        self.view = view
    }
    
    
    // MARK: - Interface

    func dismissButtonTapped() {
        guard let view = view else { return }
        view.dismiss(animated: true, completion: nil)
    }
    

    deinit {
        //        print("deinit FavoritesRouter_CN")
    }
    
}
