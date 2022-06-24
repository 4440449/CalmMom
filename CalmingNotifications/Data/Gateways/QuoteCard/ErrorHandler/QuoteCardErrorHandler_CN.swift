//
//  QuoteCardErrorHandler_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 24.06.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation
import BabyNet


enum QuoteCardError_CN: Error {
    case noInternetConnection
    case networkError
    case internalLogicError
    case localStorageError
    case unknownError
    //    case nativeServiceError
}


protocol QuoteCardErrorHandlerProtocol_CN: DataLayerErrorHandlerProtocol_CN { }


final class QuoteCardErrorHandler_CN: QuoteCardErrorHandlerProtocol_CN {
    
    func handle(_ error: Error) -> Error {
        print(" *+*- \(error) *+*-")
        if let error = error as? BabyNetError {
            switch error {
            case .badRequest(let err):
                if let err = err as? URLError, (err.code == .notConnectedToInternet || err.code == .dataNotAllowed) {
                    return QuoteCardError_CN.noInternetConnection
                } else {
                    return QuoteCardError_CN.networkError
                }
            default:
                return QuoteCardError_CN.networkError
            }
        } else if let _ = error as? QuoteCardNetworkEntityError_CN {
            return QuoteCardError_CN.internalLogicError
        } else if let _ = error as? QuoteCardLocalStorageError {
            return QuoteCardError_CN.localStorageError
        } else {
            return QuoteCardError_CN.unknownError
        }
    }
}
