//
//  QuoteCardRepository_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//


final class QuoteCardRepository_CN: QuoteCardGateway_CN {
 
    // MARK: - Dependencies
    
    private let network: QuoteCardNetworkRepositoryProtocol_CN
    private let localStorage: QuoteCardPersistenceRepositoryProtocol_CN
    
    
    init(network: QuoteCardNetworkRepositoryProtocol_CN,
         localStorage: QuoteCardPersistenceRepositoryProtocol_CN) {
        self.network = network
        self.localStorage = localStorage
    }
    
    // MARK: - Interface impl
    
    func fetch() async -> QuoteCard_CN {
        return QuoteCard_CN(quote: "", imagePath: "")
    }
}
