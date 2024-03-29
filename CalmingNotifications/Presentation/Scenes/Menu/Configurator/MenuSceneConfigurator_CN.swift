//
//  MenuSceneConfigurator_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


final class MenuSceneConfigurator_CN: SceneConfiguratorProtocol_CN {
    
    static func configure(navigationContainer: UINavigationController, repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN) -> UIViewController {
        let repo = repositoryDIContainer.menuItem
        let router = MenuRouter_CN(navigationContainer: navigationContainer,
                                   repositoryDIContainer: repositoryDIContainer)
        let errorHandler = MenuErrorHandler_CN()
        let viewModel = MenuViewModel_CN(router: router,
                                         errorHandler: errorHandler,
                                         repository: repo)
        let customTransition = MenuTransitionDelegate_CN()
        let view = MenuViewController_CN(viewModel: viewModel,
                                         customTransition: customTransition,
                                         nibName: nil,
                                         bundle: nil)
        view.modalPresentationStyle = .custom
        view.transitioningDelegate = customTransition
        router.view = view
        return view
    }
    
}
