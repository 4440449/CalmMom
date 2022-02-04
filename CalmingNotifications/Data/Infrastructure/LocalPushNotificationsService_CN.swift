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
    func fetchNotifications() async -> [UNNotificationRequest]
    func addNewNotification(at time: Date, quote: String) async throws
    func changeNotification(with identifier: String, new time: Date) async throws
    func removeNotification(with identifier: String) async throws
}


final class LocalPushNotificationsService_CN: LocalPushNotificationsServiceProtocol_CN {
    
    
    // MARK: - Dependencies

    private let center = UNUserNotificationCenter.current()
    
    
    // MARK: - Interface

    func fetchNotifications() async -> [UNNotificationRequest] {
        let result = await center.pendingNotificationRequests()
        return result
    }
    
    
    func addNewNotification(at time: Date, quote: String) async throws {
        let content = UNMutableNotificationContent()
        content.body = quote
        content.sound = .default
//            cont.title = "Moms' Exhale"
        let components = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components,
                                                    repeats: true)
        let request = UNNotificationRequest(identifier: String(describing: components),
                                            content: content,
                                            trigger: trigger)
        try await center.add(request)
    }
    
  
    func removeNotification(with identifier: String) async throws {
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        let result = await fetchNotifications()
        try result.forEach {
            if $0.identifier == identifier {
                throw LocalPushNotificationCenterError.failureRemoving("Removing notification error! Request with identifier --> \(identifier) not deleted")
            } else {
                return
            }
        }
    }
    
    
    func changeNotification(with identifier: String, new time: Date) async throws {
        let notifications = await center.pendingNotificationRequests()
        let notification = notifications.filter { $0.identifier == identifier }
        guard let quote = notification.first?.content.body else {
            throw LocalPushNotificationCenterError.failureFetching("Request with identifier --> '\(identifier)' not found ::: Fetched identifiers == \(notifications.map { $0.identifier })")
        }
        try await removeNotification(with: identifier)
        try await addNewNotification(at: time, quote: quote)
    }
    
}


// MARK: - Errors

enum LocalPushNotificationCenterError: Error {
    case failureRemoving(String)
    case failureMapping(String)
    case failureFetching(String)
}


//"Закрой глаза.. Глубойкий вдох - выдох.. Ты съела все мороженое. Остановись.."
