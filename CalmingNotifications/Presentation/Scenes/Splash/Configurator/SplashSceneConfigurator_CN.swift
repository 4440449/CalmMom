//
//  SplashSceneConfigurator_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 04.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


final class SplashSceneConfigurator_CN: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let network = QuoteCardNetworkRepository()
        let localStorage = QuoteCardPersistenceRepository()
        let repo = QuoteCardRepository_CN(network: network,
                                       localStorage: localStorage)
        let router = SplashRouter_CN()
        let viewModel = SplashViewModel_CN(quoteCardRepository: repo,
                                           router: router)
        let view = SplashViewController_CN(viewModel: viewModel,
                                           nibName: nil,
                                           bundle: nil)
        return view
    }
    
    deinit {
        print("SplashSceneConfigurator_CN is deinit -------- ")
    }
        
}
