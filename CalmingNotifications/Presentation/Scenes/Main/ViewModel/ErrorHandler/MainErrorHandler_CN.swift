//
//  MainErrorHandler_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 14.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation


protocol MainErrorHandlerProtocol_CN {
    func handle(_ error: Error) -> String
}


final class MainErrorHandler_CN: MainErrorHandlerProtocol_CN {
    
    func handle(_ error: Error) -> String {
        print("error --> \(error)")
        return ""
    }
}
