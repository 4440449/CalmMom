//
//  MenuItemRepository_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 11.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation


final class MenuItemRepository_CN: MenuItemGateway_CN {
    
    func fetch() async throws -> [MenuItem] {
        sleep(1)
        return [MenuItem(title: .favorites)]
    }
    
}
