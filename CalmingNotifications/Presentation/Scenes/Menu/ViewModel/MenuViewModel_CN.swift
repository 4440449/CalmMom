//
//  MenuViewModel_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//


protocol MenuViewModelProtocol_CN {
    
}


final class MenuViewModel_CN: MenuViewModelProtocol_CN {
    
    private let router: MenuRouterProtocol_CN
    
    init(router: MenuRouterProtocol_CN) {
        self.router = router
    }
}
