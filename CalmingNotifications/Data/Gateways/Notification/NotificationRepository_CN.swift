//
//  NotificationRepository_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation


final class NotificationRepository_CN: NotificationGateway_CN {
    
    private let network: NotificationNetworkRepositoryProtocol_CN
    private let localStorage: NotificationPersistenceRepositoryProtocol_CN
    private let localPushNotificationsService: LocalPushNotificationsServiceProtocol_CN
//    private let dtoMapper: LocalPushNotificationsDTOMapperProtocol_CN
    
    init(network: NotificationNetworkRepositoryProtocol_CN,
         localStorage: NotificationPersistenceRepositoryProtocol_CN,
         localPushNotificatiosnService: LocalPushNotificationsServiceProtocol_CN,
         dtoMapper: LocalPushNotificationsDTOMapperProtocol_CN) {
        self.network = network
        self.localStorage = localStorage
        self.localPushNotificationsService = localPushNotificatiosnService
//        self.dtoMapper = dtoMapper
    }
    
    
    func fetch() async throws -> [Notification_CN] {
        sleep(2)
        let request = await localPushNotificationsService.fetchNotifications()
        var domainEntities = [Notification_CN]()
        try request.forEach { try domainEntities.append(Notification_CN(notificationRequest: $0))
        }
        domainEntities.sort { $0.time < $1.time }
        return domainEntities
    }
    
    func addNew(at time: Date) async throws -> [Notification_CN] {
        try await localPushNotificationsService.addNewNotification(at: time)
        let result = try await fetch()
        return result
    }
    
    func change(with identifier: String, new time: Date) async throws -> [Notification_CN] {
        try await localPushNotificationsService.changeNotification(with: identifier, new: time)
        let result = try await fetch()
        return result
    }
    
    func remove(with identifire: String) async throws -> [Notification_CN] {
        try await localPushNotificationsService.removeNotification(with: identifire)
        let result = try await fetch()
        return result
    }
    
    
}
