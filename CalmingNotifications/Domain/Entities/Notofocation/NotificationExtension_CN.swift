//
//  NotificationExtension_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 24.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation
import UserNotifications

// TODO: Убрать экстеншн из доменной сущности.

//extension Notification_CN {
//    init(notificationRequest: UNNotificationRequest) throws {
//        self.id = notificationRequest.identifier
//
//        guard let trigger = notificationRequest.trigger as? UNCalendarNotificationTrigger,
//              let hour = trigger.dateComponents.hour,
//              let minute = trigger.dateComponents.minute,
//              let date = Calendar.current.date(from: DateComponents(hour: hour, minute: minute)) else {
//                  throw LocalPushNotificationCenterError.failureMapping("Error to domain entity mapping! Invalid UNNotificationRequest.trigger --> \(notificationRequest.trigger.debugDescription)")
//              }
//        self.time = date
//    }
//}



