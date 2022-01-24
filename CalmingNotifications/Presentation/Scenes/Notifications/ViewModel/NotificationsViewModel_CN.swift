//
//  NotificationsViewModel_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation
import MommysEye


protocol NotificationsViewModelProtocol_CN {
    func viewDidLoad()
    func dateSelected(date: Date)
}

protocol NotificationsHeaderViewModelProtocol_CN {
    func addNewNotification(date: Date)
}


final class NotificationsViewModel_CN: NotificationsViewModelProtocol_CN,
                                       NotificationsHeaderViewModelProtocol_CN {
    private let notificationRepository: NotificationGateway_CN
    private let router: NotificationsRouter_CN
    private let localPushNotificationService: LocalPushNotificationServiceProtocol_CN
    
    init(notificationRepository: NotificationGateway_CN,
         router: NotificationsRouter_CN,
         localPushNotificationService: LocalPushNotificationServiceProtocol_CN) {
        self.notificationRepository = notificationRepository
        self.router = router
        self.localPushNotificationService = localPushNotificationService
    }
    
    // MARK: - State
    
    var notifications = Publisher(value: [Notification_CN]())
    
    
    // MARK: - Private state / task
    
//    var task: Task<Any, Never>?
    
    
    // MARK: - Collection interface
    
    func viewDidLoad() {
        let notifTask = Task(priority: nil) {
            let result = await self.localPushNotificationService.fetchNotifications()
            var domainNotifications = [Notification_CN]()
            // Вынести в отдельный маппер!
            result.forEach {
                let domainEntity = try! Notification_CN(notificationRequest: $0);
                domainNotifications.append(domainEntity)
            }
            self.notifications.value = domainNotifications
        }
    }
//    private var selectedDate: Date?
    
    func dateSelected(date: Date) {
        print("NotificationsViewModel_CN == \(date)")
        localPushNotificationService.addNewNotification(at: date)
    }
    

    
    
    // MARK: - Header interface
    
    func addNewNotification(date: Date) {
        let task = Task.init(priority: nil) {
            self.localPushNotificationService.addNewNotification(at: date)
        }
    }
    
    
    deinit {
        print("deinit NotificationsViewModel_CN")
    }
}
