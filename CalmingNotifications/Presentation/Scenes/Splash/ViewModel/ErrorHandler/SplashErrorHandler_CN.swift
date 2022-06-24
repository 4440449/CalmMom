//
//  SplashErrorHandler_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 24.06.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation



protocol SplashErrorHandlerProtocol_CN: PresentationLayerErrorHandlerProtocol_CN { }


final class SplashErrorHandler_CN: SplashErrorHandlerProtocol_CN {
    
    func handle(_ error: Error) -> String {
        if let error = error as? QuoteCardError_CN {
            switch error {
            case .noInternetConnection:
                return "Отсутствует интернет соединение, проверьте подключение и попробуйте еще раз"
            case .networkError:
                return "Ой, какая-то внешняя проблема, простите! Мы уже все чиним, попробуйте зайти позднее"
                
                // TODO: - Как передать разные экшены в алерт?
            case .internalLogicError:
                return "Ой, какая-то внутренняя проблема, пожалуйста отправьте отчет разработчикам"
            case .localStorageError:
                return "Ошибка хранилища, попробуйте переустановить приложение"
            case .unknownError:
                return "Неизвестная ошибка"
            }
        } else {
            return "Unknown error"
        }
    }
}