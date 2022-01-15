//
//  MainViewModel_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//


protocol MainViewModelProtocol_CN {
    func viewDidLoad()
    func menuButtonTapped()
}


final class MainViewModel_CN: MainViewModelProtocol_CN {
    
    
    // MARK: - Dependencies
    
    private let quoteCardRepository: QuoteCardGateway_CN
    private let router: MainRouterProtocol_CN
    
    init(quoteCardRepository: QuoteCardGateway_CN,
         router: MainRouterProtocol_CN) {
        self.quoteCardRepository = quoteCardRepository
        self.router = router
    }
    
    // MARK: - State
    
    var quoteCard: QuoteCard_CN?
    
    private var quoteTask: Task<QuoteCard_CN, Error>? {
        willSet {
            self.quoteTask?.cancel()
        }
    }
    
    
    // MARK: - Interface impl
    
    func viewDidLoad() {
        quoteTask = Task {
            await quoteCardRepository.fetch()
        }
    }
    
    func menuButtonTapped() {
        router.move()
    }
    
  
}
