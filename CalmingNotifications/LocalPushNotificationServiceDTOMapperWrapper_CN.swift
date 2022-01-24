//
//  LocalPushNotificationServiceDTOMapperWrapper_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 24.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation


final class LocalPushNotificationServiceDTOMapperWrapper_CN {
    
    private let notificationService: LocalPushNotificationServiceProtocol_CN
    
    init(notificationService: LocalPushNotificationServiceProtocol_CN) {
        self.notificationService = notificationService
    }
    
    func request<RequestValue>(callback: @escaping () -> Result<RequestValue, Error> ) {
        
    }
}
