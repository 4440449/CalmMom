//
//  NotificationSceneConfigurator_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


final class NotificationSceneConfigurator_CN: SceneConfiguratorProtocol_CN {
    
    static func configure(navigationContainer: UIViewController,
                          repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN,
                          quotes: [String]) -> UIViewController {
        let repo = repositoryDIContainer.notification
        let router = NotificationsRouter_CN(
            navigationContainer: navigationContainer,
            repositoryDIContainer: repositoryDIContainer )
        let errorHandler = NotificationsErrorHandler_CN()
        let viewModel = NotificationsViewModel_CN(repository: repo,
                                                  router: router,
                                                  errorHandler: errorHandler,
                                                  quotes: quotes)
        let view = NotificationsViewController_CN(viewModel: viewModel,
                                                  nibName: nil,
                                                  bundle: nil)
        return view
    }
}
