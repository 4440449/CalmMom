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
    var notifications: Publisher<[Notification_CN]> { get }
    var isLoading: Publisher<Loading_CN> { get }
    var error: Publisher<String> { get }
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
         errorHandler: NotificationsErrorHandlerProtocol_CN,
         quotes: [String]) {
        self.notificationRepository = notificationRepository
        self.router = router
        self.errorHandler = errorHandler
        self.quotes = quotes
    }
    
    // MARK: - State / Observable
    
    var notifications = Publisher(value: [Notification_CN]())
    var isLoading = Publisher(value: Loading_CN.false)
    var error = Publisher(value: "")
    
    
    // MARK: - Private state / Task
    
    private var task: Task<(), Never>? { willSet { self.task?.cancel() } }
    private var quotes = [String]()
    
    
    // MARK: - Collection interface
    
    func viewDidLoad() {
        isLoading.value = .true
        task = Task(priority: nil) {
            do {
                let result = try await self.notificationRepository.fetch()
                self.notifications.value = result
            } catch let error {
                self.error.value = self.errorHandler.handle(error: error)
            }
            self.isLoading.value = .false
        }
    }

    
    // MARK: - Header interface
    
    func addNewNotificationButtonTapped(date: Date) {
        isLoading.value = .true
        task = Task(priority: nil) {
            do {
                guard let rndmQuote = self.quotes.randomElement() else { return }
                let result = try await self.notificationRepository.addNew(at: date, quote: rndmQuote)
                self.notifications.value = result
            } catch let error {
                self.error.value = self.errorHandler.handle(error: error)
            }
            self.isLoading.value = .false
        }
    }
    
    
    // MARK: - Cell interface
    
    func saveButtonTapped(cellWithIndex index: Int, new time: Date) {
        isLoading.value = .true
        task = Task(priority: nil) {
            do {
                let result = try await self.notificationRepository.change(with: notifications.value[index].id, new: time)
                self.notifications.value = result
            } catch let error {
                self.error.value = self.errorHandler.handle(error: error)
            }
            self.isLoading.value = .false
        }
    }
    
    func deleteButtonTapped(cellWithIndex index: Int) {
        isLoading.value = .true
        task = Task(priority: nil) {
            do {
                let result = try await notificationRepository.remove(with: self.notifications.value[index].id)
                self.notifications.value = result
            } catch let error {
                self.error.value = self.errorHandler.handle(error: error)
            }
            self.isLoading.value = .false
        }
    }
    
    
    deinit {
        print("deinit NotificationsViewModel_CN")
    }
}
