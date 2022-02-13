//
//  FavoritesViewModel_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 08.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import MommysEye


protocol FavoritesViewModelProtocol_CN {
    func viewDidLoad()
    func dismissButtonTapped()
    var quoteCards: Publisher<[QuoteCard_CN]> { get }
    var isLoading: Publisher<Loading_CN> { get }
    var error: Publisher<String> { get }
}

protocol FavoritesCellViewModelProtocol_CN {
    func likeButtonTapped(cellWithIndex: Int)
    func shareButtonTapped(cellWithIndex: Int)
}


final class FavoritesViewModel_CN: FavoritesViewModelProtocol_CN,
                                   FavoritesCellViewModelProtocol_CN {
    
    // MARK: - Dependencies
    
    private let router: FavoritesRouterProtocol_CN
    private let quoteCardRepository: QuoteCardGateway_CN
    private let errorHandler: FavoritesErrorHandlerProtocol_CN
    
    
    // MARK: - Init
    
    init(router: FavoritesRouterProtocol_CN,
         quoteCardRepository: QuoteCardGateway_CN,
         errorHandler: FavoritesErrorHandlerProtocol_CN) {
        self.router = router
        self.quoteCardRepository = quoteCardRepository
        self.errorHandler = errorHandler
    }
    
    
    // MARK: - State
    
    var quoteCards = Publisher(value: [QuoteCard_CN]())
    var isLoading = Publisher(value: Loading_CN.false)
    var error = Publisher(value: "")
    
    
    // MARK: - Private state
    
    private var quoteTask: Task<Void, Error>? {
        willSet {
            self.quoteTask?.cancel()
        }
    }
    
    
    // MARK: - Interface
    
    func viewDidLoad() {
        isLoading.value = .true
        quoteTask = Task {
            do {
                let result = try await quoteCardRepository.fetchFavorites()
                self.quoteCards.value = result
                //                self.quoteCards.value = []
            } catch let error {
                let errorMessage = self.errorHandler.handle(error)
                self.error.value = errorMessage
            }
            self.isLoading.value = .false
        }
    }
    
    func dismissButtonTapped() {
        router.dismissButtonTapped()
    }
    
    func likeButtonTapped(cellWithIndex: Int) {
        switch quoteCards.value[cellWithIndex].isFavorite {
        case false:
            quoteTask = Task {
                do {
                    var quoteCard = self.quoteCards.value[cellWithIndex]
                    quoteCard.isFavorite = true
                    try await self.quoteCardRepository.saveFavorite(quoteCard)
                    self.quoteCards.value[cellWithIndex] = quoteCard
                } catch let error {
                    let errorMessage = self.errorHandler.handle(error)
                    self.error.value = errorMessage
                }
            }
        case true:
            quoteTask = Task {
                do {
                    var quoteCard = self.quoteCards.value[cellWithIndex]
                    quoteCard.isFavorite = false
                    try await self.quoteCardRepository.deleteFavorite(quoteCard)
                    self.quoteCards.value[cellWithIndex] = quoteCard
//                    self.quoteCards.value[cellWithIndex].isFavorite = false
//                    self.quoteCards.value = result
                } catch let error {
                    let errorMessage = self.errorHandler.handle(error)
                    self.error.value = errorMessage
                }
            }
        }
        
    }
    
    func shareButtonTapped(cellWithIndex: Int) {
        
    }
    
    deinit {
        //        print("deinit FavoritesViewModel_CN")
    }
}
