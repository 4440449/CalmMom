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
    private let dtoMapper: LocalPushNotificationsDTOMapperProtocol_CN
    
    init(network: NotificationNetworkRepositoryProtocol_CN,
         localStorage: NotificationPersistenceRepositoryProtocol_CN,
         localPushNotificatiosnService: LocalPushNotificationsServiceProtocol_CN,
         dtoMapper: LocalPushNotificationsDTOMapperProtocol_CN) {
        self.network = network
        self.localStorage = localStorage
        self.localPushNotificationsService = localPushNotificatiosnService
        self.dtoMapper = dtoMapper
    }
    
    
    func fetch() async throws -> [Notification_CN] {
        let request = await localPushNotificationsService.fetchNotifications()
        var domainEntities = [Notification_CN]()
        try request.forEach { try domainEntities.append(Notification_CN(notificationRequest: $0))
        }
        return domainEntities
    }
    
    func addNew(at time: Date) async throws {
        try await localPushNotificationsService.addNewNotification(at: time)
    }
    
    func change(with identifier: String, new time: Date) async throws {
        try await localPushNotificationsService.changeNotification(with: identifier, new: time)
    }
    
    func remove(with identifire: String) async throws {
        try await localPushNotificationsService.removeNotification(with: identifire)
    }
    
    
}
