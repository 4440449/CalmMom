//
//  QuoteCardGateway_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

protocol QuoteCardGateway_CN {
    func getState() -> QuoteCardStateProtocol_CN
    func fetch() async throws
    func fetchFavorites() async throws -> [QuoteCard_CN]
    func saveFavorite(_ quoteCard: QuoteCard_CN) async throws
    func deleteFavorite(_ quoteCard: QuoteCard_CN) async throws
}
