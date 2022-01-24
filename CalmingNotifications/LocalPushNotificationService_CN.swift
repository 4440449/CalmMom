//
//  NotificationService_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 18.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UserNotifications
import Foundation


protocol LocalPushNotificationServiceProtocol_CN {
    // Collection interface
    func addNewNotification(at time: Date) //async throws
    func fetchNotifications() async -> [UNNotificationRequest]
    // Cell interface
    func changeNotification(with identifier: String, new time: Date) async throws
    func removeNotification(with identifire: String) async
}


final class LocalPushNotificationService_CN: LocalPushNotificationServiceProtocol_CN {
  
    private let center = UNUserNotificationCenter.current()
    
    func addNewNotification(at time: Date) {
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
        center.add(request) { error in
            print("Error adding notification, error description --> \(error)")
        }
        
    }
    
    func fetchNotifications() async -> [UNNotificationRequest] {
        let notif = await center.pendingNotificationRequests()
        return notif
    }
    
    func removeNotification(with identifire: String) async {
        center.removePendingNotificationRequests(withIdentifiers: [identifire])
    }
    
    func changeNotification(with identifier: String, new time: Date) async throws {
        await removeNotification(with: identifier)
        // await
        addNewNotification(at: time)
    }
    

    
    
}
