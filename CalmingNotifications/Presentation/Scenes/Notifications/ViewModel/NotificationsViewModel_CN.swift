//
//  NotificationsViewModel_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation


protocol NotificationsViewModelProtocol_CN {
    func dateSelected(date: Date)
}


final class NotificationsViewModel_CN: NotificationsViewModelProtocol_CN {
    
    private let notificationRepository: NotificationGateway_CN
    private let router: NotificationsRouter_CN
    private let localNotificationService: LocalNotificationServiceProtocol_CN
    
    init(notificationRepository: NotificationGateway_CN,
         router: NotificationsRouter_CN,
         localNotificationService: LocalNotificationServiceProtocol_CN) {
        self.notificationRepository = notificationRepository
        self.router = router
        self.localNotificationService = localNotificationService
    }
    
    
//    private var selectedDate: Date?
    
    func dateSelected(date: Date) {
        print("NotificationsViewModel_CN == \(date)")
        localNotificationService.setNotification(at: date)
    }
    
//    func saveButtonTapped() {
//        guard let date = selectedDate else { return }
//        localNotificationService.setNotification(at: date)
//    }
    
    deinit {
        print("deinit NotificationsViewModel_CN")
    }
}
