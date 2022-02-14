//
//  QuoteCardRepository_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit
import Foundation


final class QuoteCardRepository_CN: QuoteCardGateway_CN {
    
    // MARK: - Dependencies
    
    private let network: QuoteCardNetworkRepositoryProtocol_CN
    private let localStorage: QuoteCardPersistenceRepositoryProtocol_CN
    private let quoteCardState: QuoteCardStateProtocol_CN
    
    
    // MARK: - Init
    
    init(network: QuoteCardNetworkRepositoryProtocol_CN,
         localStorage: QuoteCardPersistenceRepositoryProtocol_CN,
         quoteCardState: QuoteCardStateProtocol_CN) {
        self.network = network
        self.localStorage = localStorage
        self.quoteCardState = quoteCardState
    }
    
    
    // MARK: - Interface
    
    func getState() -> QuoteCardStateProtocol_CN {
        return quoteCardState
    }
    
    
    func setState() async throws {
        // Stub! there is no backend yet
        // С бэека могут приходить картинки вообще без поля isFavorite. В момент прихода фронт сам синхронизирует состояние isFavorite сравнивая id
        // let task = { network.connect(url...) { result in
//        switch result { case .success (let cards): let favorites = localStorage.fetchFavorites() ...
//    } } }
        sleep(1) // Имитация нетворк реквеста
        let favorites = try await localStorage.fetchFavorites()
        var cards = quoteCardState.quoteCards.value
        for favorite in favorites {
            for (index, quoteCard) in cards.enumerated() {
                if favorite.id == quoteCard.id {
                    cards.remove(at: index)
                    cards.insert(favorite, at: index)
                }
            }
        }
        quoteCardState.quoteCards.value = cards
    }
    
    func fetchFavorites() async throws -> [QuoteCard_CN] {
        let result = try await localStorage.fetchFavorites()
        return result
    }
    
    func saveFavorite(_ quoteCard: QuoteCard_CN) async throws{
        try await localStorage.saveFavorite(quoteCard)
        for (index, card) in quoteCardState.quoteCards.value.enumerated() {
            if card.id == quoteCard.id {
                quoteCardState.quoteCards.value[index].isFavorite = true
            }
        }
    }
    
    func deleteFavorite(_ quoteCard: QuoteCard_CN) async throws {
        try await localStorage.deleteFavorite(quoteCard)
        for (index, card) in quoteCardState.quoteCards.value.enumerated() {
            if card.id == quoteCard.id {
                quoteCardState.quoteCards.value[index].isFavorite = false
            }
        }
    }
    
    
    deinit {
        //        print("QuoteCardRepository_CN is deinit -------- ")
    }
}

