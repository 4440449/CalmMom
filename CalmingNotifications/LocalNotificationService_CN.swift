//
//  NotificationService_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 18.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UserNotifications
import Foundation


protocol LocalNotificationServiceProtocol_CN {
    func setNotification(at time: Date)
}


final class LocalNotificationService_CN: LocalNotificationServiceProtocol_CN {
    
    private let center = UNUserNotificationCenter.current()
    
    func setNotification(at time: Date) {
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
}
