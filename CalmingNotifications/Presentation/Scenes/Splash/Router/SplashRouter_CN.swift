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
    
    func startMainFlow(quoteCards: [QuoteCard_CN]) {
        DispatchQueue.main.async {
            let tabBarVC = MainTabBarViewController_CN(quoteCards: quoteCards,
                                                       nibName: nil,
                                                       bundle: nil)
            if let sceneDelegate =
                UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarVC
                sceneDelegate.window?.makeKeyAndVisible() // надо?
            }
        }
    }
    
}
