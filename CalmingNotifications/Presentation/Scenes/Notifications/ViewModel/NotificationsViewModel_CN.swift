//
//  NotificationsViewModel_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//


protocol NotificationsViewModelProtocol_CN {
    
}


final class NotificationsViewModel_CN: NotificationsViewModelProtocol_CN {
    
    private let notificationRepository: NotificationGateway_CN
    private let router: NotificationsRouter_CN
    
    init(notificationRepository: NotificationGateway_CN,
         router: NotificationsRouter_CN) {
        self.notificationRepository = notificationRepository
        self.router = router
    }
}
