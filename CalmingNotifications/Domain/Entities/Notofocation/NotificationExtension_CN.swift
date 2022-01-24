//
//  NotificationExtension_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 24.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation
import UserNotifications


extension Notification_CN {
    init(notificationRequest: UNNotificationRequest) throws {
        self.id = notificationRequest.identifier
        
        guard let calendar = notificationRequest.trigger as? UNCalendarNotificationTrigger,
              let hour = calendar.dateComponents.hour,
              let minute = calendar.dateComponents.minute else {
                  throw NotificationMapperError.failureMapping("Error to domain entity mapping! Invalid UNNotificationRequest.trigger --> \(notificationRequest.trigger.debugDescription)")
              }
        let components = DateComponents(hour: hour, minute: minute)
        self.time = components
    }
}

enum NotificationMapperError: Error {
    case failureMapping(String)
}
