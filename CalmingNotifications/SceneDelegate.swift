//
//  SceneDelegate.swift
//  CalmingNotifications
//
//  Created by Max on 10.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit
import MommysEye

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let sceneState = Publisher(value: SceneState.background)

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let repositoryDIContainer = GatewaysRepositoryDIContainer_CN(
            quoteCard:
                GatewaysRepositoryDIContainer_CN.createQuoteCardRepository(),
            notification:
                GatewaysRepositoryDIContainer_CN.createNotificationRepository(),
            menuItem:
                GatewaysRepositoryDIContainer_CN.createMenuItemRepository() )
        let splashVC = SplashSceneConfigurator_CN.configure(
            repositoryDIContainer: repositoryDIContainer )
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        sceneState.value = .foreground
        print("foregr UIApplication.shared.applicationState == \(UIApplication.shared.applicationState.rawValue)")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        sceneState.value = .background
        print("backr UIApplication.shared.applicationState == \(UIApplication.shared.applicationState.rawValue)")
    }

}

