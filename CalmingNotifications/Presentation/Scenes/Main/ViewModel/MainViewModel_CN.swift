//
//  MainViewModel_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import MommysEye
import UIKit


protocol MainViewModelProtocol_CN {
    func viewDidLoad()
    func menuButtonTapped()
    var quoteCard: Publisher<[QuoteCard_CN]> { get }
    var isLoading: Publisher<Loading_CN> { get }
}

protocol MainCellViewModelProtocol_CN {
    func likeButtonTapped(cellWithIndex: Int)
    func shareButtonTapped(cellWithIndex index: Int)
}


final class MainViewModel_CN: MainViewModelProtocol_CN,
                              MainCellViewModelProtocol_CN {
    
    
    // MARK: - Dependencies
    
    private let quoteCardRepository: QuoteCardGateway_CN
    private let router: MainRouterProtocol_CN
    
    init(quoteCardRepository: QuoteCardGateway_CN,
         router: MainRouterProtocol_CN) {
        self.quoteCardRepository = quoteCardRepository
        self.router = router
    }
    
    // MARK: - State
    
    var quoteCard = Publisher(value: [QuoteCard_CN]())
    var isLoading = Publisher(value: Loading_CN.false)
    
    
    // MARK: - Private state
    
    private var quoteTask: Task<Void, Error>? {
        willSet {
            self.quoteTask?.cancel()
        }
    }
    
    
    // MARK: - Interface impl
    
    func viewDidLoad() {
        isLoading.value = .true
        quoteTask = Task {
            let result = await quoteCardRepository.fetch()
            self.quoteCard.value = result
            isLoading.value = .false
        }
    }
    
    func menuButtonTapped() {
        router.move()
    }
    
    
    func likeButtonTapped(cellWithIndex index: Int) {
        UIImageWriteToSavedPhotosAlbum(quoteCard.value[index].image,
                                       nil,
                                       nil,
                                       nil)
    }
    
    func shareButtonTapped(cellWithIndex index: Int) {
        router.showActivity(with: quoteCard.value[index])
    }
    
    
}
