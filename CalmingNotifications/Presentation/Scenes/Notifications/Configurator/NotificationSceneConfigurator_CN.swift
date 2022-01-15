//
//  NotificationSceneConfigurator_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


final class NotificationSceneConfigurator_CN: SceneConfiguratorProtocol_CN {
    
    static func configure(navigationContainer: UIViewController) -> UIViewController {
        
        let network = NotificationNetworkRepository_CN()
        let localStorage = NotificationPersistenceRepository_CN()
        let repo = NotificationRepository_CN(network: network,
                                             localStorage: localStorage)
        let router = NotificationsRouter_CN(navigationContainer: navigationContainer)
        let viewModel = NotificationsViewModel_CN(notificationRepository: repo,
                                                  router: router)
        let view = NotificationsViewController_CN(viewModel: viewModel,
                                                  nibName: nil,
                                                  bundle: nil)
        return view
    }
}
