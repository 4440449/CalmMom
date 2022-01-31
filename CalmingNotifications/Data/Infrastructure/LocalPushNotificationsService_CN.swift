//
//  NotificationService_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 18.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UserNotifications
import Foundation


protocol LocalPushNotificationsServiceProtocol_CN {
    // Collection interface
    func fetchNotifications() async -> [UNNotificationRequest]
    func addNewNotification(at time: Date) async throws
    // Cell interface
    func changeNotification(with identifier: String, new time: Date) async throws
    func removeNotification(with identifire: String) async throws
}


final class LocalPushNotificationsService_CN: LocalPushNotificationsServiceProtocol_CN {
    
    private let center = UNUserNotificationCenter.current()
    
    func addNewNotification(at time: Date) async throws {
        let content: UNMutableNotificationContent = {
            let cont = UNMutableNotificationContent()
            cont.title = "Moms' Exhale"
            cont.body = "Закрой глаза.. Глубойкий вдох - выдох.. Ты съела все мороженое. Остановись.."
            cont.sound = .default
            return cont
        }()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: String(describing: components),
                                            content: content,
                                            trigger: trigger)
        print("calendar = \(calendar)")
        print("components = \(components)")
        print("trigger = \(trigger)")
        print("request = \(request)")
        try await center.add(request)
    }
    
    func fetchNotifications() async -> [UNNotificationRequest] {
        let result = await center.pendingNotificationRequests()
//        let notif = await center.pendingNotificationRequests()
        return result
    }
    
    func removeNotification(with identifire: String) async throws {
        center.removePendingNotificationRequests(withIdentifiers: [identifire])
        let result = await fetchNotifications()
        try result.forEach {
            if $0.identifier == identifire {
                throw NotificationMapperError.failureRemoving("Removing notification error! Request with identifier --> \(identifire) not deleted")
            } else {
                return
            }
        }
    }
    
    func changeNotification(with identifier: String, new time: Date) async throws {
        try await removeNotification(with: identifier)
        try await addNewNotification(at: time)
    }
    
    
    
    
}
