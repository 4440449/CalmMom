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
    var error: Publisher<String> { get }
}


final class MenuViewModel_CN: MenuViewModelProtocol_CN {
   
    // MARK: - Dependencies

    private let router: MenuRouterProtocol_CN
    private let errorHandler: MenuErrorHandlerProtocol_CN
    private let repository: MenuItemGateway_CN
    
    
    // MARK: - Init
    
    init(router: MenuRouterProtocol_CN,
         errorHandler: MenuErrorHandlerProtocol_CN,
         repository: MenuItemGateway_CN) {
        self.router = router
        self.errorHandler = errorHandler
        self.repository = repository
    }
    
    
    // MARK: - State

    var menuItems = Publisher(value: [MenuItem]())
    var error = Publisher(value: "")
    
    
    // MARK: - Private state / Task
    
    private var task: Task<(), Never>? { willSet { self.task?.cancel() } }
    
    
    // MARK: - Interface

    func viewDidLoad() {
        menuItems.notify()
        task = Task {
            do {
                let result = try await self.repository.fetch()
                self.menuItems.value = result
            } catch let error {
                let message = self.errorHandler.handle(error)
                self.error.value = message
            }
        }
    }
    
    func didSelectItemAt(index: Int) {
        router.didSelect(item: menuItems.value[index])
    }

}
