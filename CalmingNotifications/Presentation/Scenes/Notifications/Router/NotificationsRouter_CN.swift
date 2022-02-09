//
//  NotificationsRouter_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit

protocol NotificationsRouterProtocol_CN {
   func move()
}


final class NotificationsRouter_CN: NotificationsRouterProtocol_CN {
    
    private weak var navigationContainer: UIViewController?
    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN
    
    init(navigationContainer: UIViewController,
         repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN) {
        self.navigationContainer = navigationContainer
        self.repositoryDIContainer = repositoryDIContainer
    }
    
    func move() {
        
    }
    
    deinit {
        print("deinit NotificationsRouter_CN")
    }
        
}
