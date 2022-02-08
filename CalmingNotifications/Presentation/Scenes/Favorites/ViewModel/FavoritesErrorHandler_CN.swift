//
//  FavoritesErrorHandler_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 08.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation


protocol FavoritesErrorHandlerProtocol_CN {
    func handle(_ error: Error) -> String
}


final class FavoritesErrorHandler_CN: FavoritesErrorHandlerProtocol_CN {
    
    func handle(_ error: Error) -> String {
        print("error --> \(error)")
        return ""
    }
}
