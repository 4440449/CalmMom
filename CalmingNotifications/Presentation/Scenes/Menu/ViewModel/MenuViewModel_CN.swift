//
//  MenuViewModel_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import MommysEye


protocol MenuViewModelProtocol_CN {
    func viewDidLoad()
    func didSelectItemAt(index: Int)
    var menuItems: Publisher<[MenuItem]> { get }
    
}


final class MenuViewModel_CN: MenuViewModelProtocol_CN {
   
    // MARK: - Dependencies

    private let router: MenuRouterProtocol_CN
    
    
    // MARK: - Init
    
    init(router: MenuRouterProtocol_CN) {
        self.router = router
    }
    
    
    // MARK: - State

    var menuItems = Publisher(value: [MenuItem]())
    
    
    // MARK: - Interface

    func viewDidLoad() {
        menuItems.value = [MenuItem(title: .favorites)]
    }
    
    func didSelectItemAt(index: Int) {
        router.didSelect(item: menuItems.value[index])
    }

}
