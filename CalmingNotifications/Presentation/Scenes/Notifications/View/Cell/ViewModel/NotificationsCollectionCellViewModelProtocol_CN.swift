//
//  NotificationsCollectionCellViewModelProtocol_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 24.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation


protocol NotificationsCollectionCellViewModelProtocol_CN {
    func changeNotificationTime(time: Date)
}


struct NotificationsCollectionCellViewModel_CN {
    
    // MARK: - Dependencies
    
    private let localPushNotificationsService: LocalPushNotificationServiceProtocol_CN
    
    
    // MARK: - Init
    
    init(localPushNotificationsService: LocalPushNotificationServiceProtocol_CN,
         notificationTime: Date) {
        self.localPushNotificationsService = localPushNotificationsService
        self.notificationTime = notificationTime
    }
    
    // MARK: - State / Output
    
    var notificationTime: Date?
    
    
    // MARK: - Actions / Interface
    
    func changeNotificationTime(time: Date) {
        
    }
    
    // MARK: - Private
    
    private func getNotificationTime(notificationIdentifier: String?) {
        
    }
    
}
