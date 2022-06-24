//
//  NotificationsErrorHandler_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 24.06.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation
import BabyNet


enum NotificationsError_CN: Error {
    case nativeServiceError
    case unknownError
}


protocol NotificationsErrorHandlerProtocol_CN: DataLayerErrorHandlerProtocol_CN { }



final class NotificationsErrorHandler_CN: NotificationsErrorHandlerProtocol_CN {
    
    func handle(_ error: Error) -> Error {
        print(" *+*- \(error) *+*-")
        if let _ = error as? LocalPushNotificationCenterError {
            return NotificationsError_CN.nativeServiceError
        } else {
            return NotificationsError_CN.unknownError
        }
    }
}





//final class NotificationsErrorHandler_CN: ErrorHandlerProtocol_CN {
//    func handle(_ error: Error) -> String {
//        print(error) //log
//        if let _ = error as? LocalPushNotificationCenterError {
//            return "Внутренняя ошибка хранилища"
//        } else {
//            return "Неизвестная ошибка"
//        }
//    }
//}
