//
//  NotificationRepository_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//


final class NotificationRepository_CN: NotificationGateway_CN {
    
    private let network: NotificationNetworkRepositoryProtocol_CN
    private let localStorage: NotificationPersistenceRepositoryProtocol_CN
    
    init(network: NotificationNetworkRepositoryProtocol_CN,
         localStorage: NotificationPersistenceRepositoryProtocol_CN) {
        self.network = network
        self.localStorage = localStorage
    }
    
}
