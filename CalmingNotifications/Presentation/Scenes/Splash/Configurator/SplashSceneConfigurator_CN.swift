//
//  SplashSceneConfigurator_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 04.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


final class SplashSceneConfigurator_CN: SceneConfiguratorProtocol_CN {
    
    static func configure(repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN) -> UIViewController {
        let repo = repositoryDIContainer.quoteCard
        let router = SplashRouter_CN(repositoryDIContainer: repositoryDIContainer)
        let viewModel = SplashViewModel_CN(quoteCardRepository: repo,
                                           router: router)
        let view = SplashViewController_CN(viewModel: viewModel,
                                           nibName: nil,
                                           bundle: nil)
        return view
    }
    
    deinit {
//        print("SplashSceneConfigurator_CN is deinit -------- ")
    }
        
}
