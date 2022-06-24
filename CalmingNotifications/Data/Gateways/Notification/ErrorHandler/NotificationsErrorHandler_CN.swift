//
//  NotificationsErrorHandler_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 24.06.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation
import BabyNet



protocol NotificationsErrorHandlerProtocol_CN: DataLayerErrorHandlerProtocol_CN { }



final class NotificationsErrorHandler_CN: NotificationsErrorHandlerProtocol_CN {
    
    func handle(_ error: Error) -> Error {
        print(" *+*- \(error) *+*-")
        if let _ = error as? LocalPushNotificationCenterError {
            return NotificationError_CN.nativeServiceError
        } else {
            return NotificationError_CN.unknownError
        }
    }
}

