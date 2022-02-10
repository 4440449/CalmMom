//
//  MainSceneConfigurator_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit


final class MainSceneConfigurator_CN: SceneConfiguratorProtocol_CN {
    
    static func configure(navigationContainer: UIViewController,
                          repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_CN,
                          quoteCards: [QuoteCard_CN]) -> UIViewController {
        let repo = repositoryDIContainer.quoteCard
        let router = MainRouter_CN(navigationContainer: navigationContainer,
                                   repositoryDIContainer: repositoryDIContainer)
        let viewModel = MainViewModel_CN(quoteCardRepository: repo,
                                         router: router,
                                         quoteCards: quoteCards)
        let view = MainViewController_CN(viewModel: viewModel,
                                         nibName: nil,
                                         bundle: nil)
        return view
    }
}
