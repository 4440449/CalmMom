//
//  QuoteCardDBEntity+CoreDataProperties.swift
//  CalmingNotifications
//
//  Created by Maxim on 08.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


extension QuoteCardDBEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteCardDBEntity> {
        return NSFetchRequest<QuoteCardDBEntity>(entityName: "QuoteCardDBEntity")
    }

    @NSManaged public var image: Data?
    @NSManaged public var quote: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isFavorite: Bool

}

extension QuoteCardDBEntity : Identifiable {

}

extension QuoteCardDBEntity {
    
    func parseToDBEntity(domain: QuoteCard_CN) throws {
        guard let pngData = domain.image.pngData() else {
            throw QuoteCardLocalStorageError.failureToDBEntityMapping("Failure PNG representation data --> \(domain.image)")
        }
        image = pngData
        quote = domain.quote
        id = domain.id
        isFavorite = domain.isFavorite
    }
    
    func parseToDomainEntity() throws -> QuoteCard_CN  {
        guard let data = self.image,
              let image = UIImage(data: data),
              let quote = self.quote,
              let id = self.id else {
                  throw QuoteCardLocalStorageError.failureToDomainEntityMapping("Invalid entity data --> \(self.debugDescription)")
              }
        return .init(quote: quote,
                     image: image,
                     id: id,
                     isFavorite: self.isFavorite)
    }
    
}
