//
//  QuoteCardPersistenceRepositoryProtocol_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//

import CoreData


protocol QuoteCardPersistenceRepositoryProtocol_CN {
    func fetchFavorites() async throws -> [QuoteCard_CN]
    func saveFavorite(_ quoteCard: QuoteCard_CN) async throws
}


final class QuoteCardPersistenceRepository: QuoteCardPersistenceRepositoryProtocol_CN {
   
    // MARK: - Dependencies

    private let coreDataContainer = CoreDataStack_CN.shared.persistentContainer
    
    
    // MARK: - Interface

    func fetchFavorites() async throws -> [QuoteCard_CN] {
        let request: NSFetchRequest = QuoteCardDBEntity.fetchRequest()
//        request.predicate = NSPredicate(format: "isFavorite == true")
//        do {
            let fetchResult = try coreDataContainer.viewContext.fetch(request)
            let domain = try fetchResult.map { try $0.parseToDomainEntity() }
                // TODO: Чекнуть ошибку если выдам ее здесь в маппинге. Как она будет выглядеть? Ошибка маппинга обернутая ошибкой фетча?
            return domain
//        } catch let error {
//            throw QuoteCardLocalStorageError.failureFetching(error)
//        }
    }
    
    func saveFavorite(_ quoteCard: QuoteCard_CN) async throws {
        let dbEntity = QuoteCardDBEntity.init(context: coreDataContainer.viewContext)
        try dbEntity.parseToDBEntity(domain: quoteCard)
        try coreDataContainer.viewContext.save()
    }
    
    
    deinit {
//        print("QuoteCardPersistenceRepository is deinit -------- ")
    }
}


enum QuoteCardLocalStorageError: Error {
//    case failureFetching(Error)
    case failureToDBEntityMapping(String)
    case failureToDomainEntityMapping(String)
}
