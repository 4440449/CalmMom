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
    
    private let navigationContainer: UIViewController
    
    init(navigationContainer: UIViewController) {
        self.navigationContainer = navigationContainer
    }
    
    func move() {
        
    }
        
}
