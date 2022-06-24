//
//  NotificationsErrorHandler_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 24.06.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation


protocol NotificationsSceneErrorHandlerProtocol_CN: PresentationLayerErrorHandlerProtocol_CN { }


final class NotificationsSceneErrorHandler_CN: NotificationsSceneErrorHandlerProtocol_CN {
    
    func handle(_ error: Error) -> String {
        if let error = error as? NotificationsError_CN {
            switch error {
            case .nativeServiceError:
                return "Ой, какая-то внутренняя проблема, пожалуйста отправьте нам отчет"
            case . unknownError:
                return "Неизвестная ошибка"
            }
        } else {
            return "Unknown error"
        }
    }
    
}
