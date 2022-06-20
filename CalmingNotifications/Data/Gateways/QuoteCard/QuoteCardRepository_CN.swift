//
//  QuoteCardRepository_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import UIKit
import Foundation
//import XCTest
//import XCTest


final class QuoteCardRepository_CN: QuoteCardGateway_CN {
    
    // MARK: - Dependencies
    
    private let network: QuoteCardNetworkRepositoryProtocol_CN
    private let localStorage: QuoteCardPersistenceRepositoryProtocol_CN
    private var quoteCardState: QuoteCardStateProtocol_CN
    
    
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
        
        let networkCards = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[QuoteCardNetworkEntity_CN], Error>) -> Void in
            let _ = self.network.fetch (callback: { result in //networkTask
                switch result {
                case let .success(networkCards):
                    continuation.resume(returning: networkCards)
                case let .failure(networkError):
                    continuation.resume(throwing: networkError)
                }
            }, taskProgressCallback: nil)
            //        taskProgressCallback: { progress in
            //                print("CalmingNotifications progress == \(progress)")
            //                self.quoteCardState.networkProgress.value = progress.fractionCompleted
            //            }
        }
        var domains = try networkCards.map { try $0.parseToDomain() }
        let favorites = try await localStorage.fetchFavorites()
        for favorite in favorites {
            for (index, domain) in domains.enumerated() {
                if favorite == domain {
                    domains[index].isFavorite = favorite.isFavorite
                }
            }
        }
        quoteCardState.quoteCards.value = domains
        let quotes = domains.map { $0.quote }
        quoteCardState.quotes.value = quotes
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
