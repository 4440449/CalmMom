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
        let splashVC = SplashSceneConfigurator_CN.configure()
        window?.rootViewController = splashVC
//        let tabBarVC = MainTabBarViewController_CN()
//        window?.rootViewController = tabBarVC
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
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        sceneState.value = .background
    }

}

