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
    var progress: Publisher<Float> { get }
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
    var progress = Publisher(value: Float(0))
    
    
    // MARK: - Private state
    
    private var quoteTask: Task<Void, Error>?
    
    
    
    // MARK: - Interface

    func viewDidLoad() {
        isLoading.value = .true
        quoteTask = Task {
            do {
                try await quoteCardRepository.setState(taskProgressCallback: { [weak self] progress in
                    self?.progress.value = Float(progress.fractionCompleted)
                })
                self.quotesLoaded()
                self.isLoading.value = .false
            } catch let error {
                print(error)
            }
        }
    }
    
//    private func quotesLoaded(quoteCards: [QuoteCard_CN]) {
//        router.startMainFlow(quoteCards: quoteCards)
//    }
    
    private func quotesLoaded() {
//        router.startMainFlow(quoteCards: quoteCards)
        router.startMainFlow()

    }
    
    deinit {
//        print("SplashViewModel_CN is deinit -------- ")
    }
    
}
