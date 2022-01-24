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
    func numberOfItems() -> Int
    
    var notifications: Publisher<[Notification_CN]> { get }
    var error: Publisher<String> { get }
    //    func dateSelected(date: Date)
}

protocol NotificationsHeaderViewModelProtocol_CN {
    func addNewNotificationButtonTapped(date: Date)
}

protocol NotificationsCellViewModelProtocol_CN {
    func saveButtonTapped(cellWithIndex index: Int, new time: Date)
    func deleteButtonTapped(cellWithIndex index: Int)
}


final class NotificationsViewModel_CN: NotificationsViewModelProtocol_CN,
                                       NotificationsHeaderViewModelProtocol_CN,
                                       NotificationsCellViewModelProtocol_CN {
    
    
    // MARK: - Dependencies
    
    private let notificationRepository: NotificationGateway_CN
    private let router: NotificationsRouterProtocol_CN
    private let errorHandler: NotificationsErrorHandlerProtocol_CN
    
    init(notificationRepository: NotificationGateway_CN,
         router: NotificationsRouterProtocol_CN,
         errorHandler: NotificationsErrorHandlerProtocol_CN) {
        self.notificationRepository = notificationRepository
        self.router = router
        self.errorHandler = errorHandler
    }
    
    // MARK: - State / Observable
    
    var notifications = Publisher(value: [Notification_CN]())
    var error = Publisher(value: "")
//    var isLoading: IsLoading
    
    
    // MARK: - Private state / Task
    
    private var task: Task<(), Never>? { willSet { self.task?.cancel() } }
    
    
    // MARK: - Collection interface
    
    func viewDidLoad() {
        task = Task(priority: nil) {
//            self.isLoading = .loading
            do {
                let result = try await self.notificationRepository.fetch()
                self.notifications.value = result
            } catch let error {
                self.error.value = self.errorHandler.handle(error: error)
            }
//            self.isLoading = .notLoading
        }
    }
    
    //    private var selectedDate: Date?
    
    func dateSelected(date: Date) {
        print("NotificationsViewModel_CN == \(date)")
        
    }
    
    func numberOfItems() -> Int {
        return notifications.value.count
    }
    
    
    // MARK: - Header interface
    
    func addNewNotificationButtonTapped(date: Date) {
        task = Task(priority: nil) {
            do {
                try await self.notificationRepository.addNew(at: date)
            } catch let error {
                self.error.value = self.errorHandler.handle(error: error)
            }
        }
    }
    
    
    // MARK: - Cell interface
    
    func saveButtonTapped(cellWithIndex index: Int, new time: Date) {
        task = Task(priority: nil) {
            do {
                try await self.notificationRepository.change(with: notifications.value[index].id, new: time)
                let calendar = Calendar.current
                let newTime = calendar.dateComponents([.hour, .minute], from: time)
                self.notifications.value[index].time = newTime
            } catch let error {
                self.error.value = self.errorHandler.handle(error: error)
            }
        }
    }
    
    func deleteButtonTapped(cellWithIndex index: Int) {
        task = Task(priority: nil) {
            do {
                try await notificationRepository.remove(with: self.notifications.value[index].id)
                self.notifications.value.remove(at: index)
            } catch let error {
                self.error.value = self.errorHandler.handle(error: error)
            }
        }
    }
    
    
    deinit {
        print("deinit NotificationsViewModel_CN")
    }
}
