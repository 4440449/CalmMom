//
//  NotificationsErrorHandler_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 24.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation


protocol NotificationsErrorHandlerProtocol_CN {
    func handle(error: Error) -> String
}


final class NotificationsErrorHandler_CN: NotificationsErrorHandlerProtocol_CN {
    
    func handle(error: Error) -> String {
        return ""
    }
}
