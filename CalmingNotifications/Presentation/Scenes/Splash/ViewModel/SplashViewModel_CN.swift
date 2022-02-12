//
//  SplashViewModel_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 04.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import MommysEye


protocol SplashViewModelProtocol_CN {
    var isLoading: Publisher<Loading_CN> { get }
    func viewDidLoad()
}


final class SplashViewModel_CN: SplashViewModelProtocol_CN {
    
    // MARK: - Dependencies

    private let quoteCardRepository: QuoteCardGateway_CN
    private let router: SplashRouterProtocol_CN
    
    
    // MARK: - Init
    
    init(quoteCardRepository: QuoteCardGateway_CN,
        router: SplashRouterProtocol_CN) {
        self.quoteCardRepository = quoteCardRepository
        self.router = router
    }
    
    
    // MARK: - State
    
    var isLoading = Publisher(value: Loading_CN.false)
    
    
    // MARK: - Private state
    
    private var quoteTask: Task<Void, Error>?
    
    
    // MARK: - Interface

    func viewDidLoad() {
        isLoading.value = .true
        quoteTask = Task {
            //do {}catch{}
            let result = await quoteCardRepository.fetch()
            self.quotesLoaded(quoteCards: result)
            self.isLoading.value = .false
        }
    }
    
    private func quotesLoaded(quoteCards: [QuoteCard_CN]) {
        router.startMainFlow(quoteCards: quoteCards)
    }
    
    deinit {
//        print("SplashViewModel_CN is deinit -------- ")
    }
    
}
