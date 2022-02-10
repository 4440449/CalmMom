//
//  SplashRouter_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 04.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import Foundation
import UIKit


protocol SplashRouterProtocol_CN {
    func startMainFlow(quoteCards: [QuoteCard_CN])
}


final class SplashRouter_CN: SplashRouterProtocol_CN {
    
    // MARK: - Dependencies

    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN
    
    
    // MARK: - Init

    init(repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN) {
        self.repositoryDIContainer = repositoryDIContainer
    }
    
    
    // MARK: - Interface

    func startMainFlow(quoteCards: [QuoteCard_CN]) {
        DispatchQueue.main.async {
            let vc = MainTabBarConfigurator_CN.configure(quoteCards: quoteCards, repositoryDIContainer: self.repositoryDIContainer)
            if let sceneDelegate =
                UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = vc
                sceneDelegate.window?.makeKeyAndVisible() // надо?
            }
        }
    }
    
    deinit {
        print("SplashRouter_CN is deinit -------- ")
    }
    
}
