//
//  GatewaysRepositoryDIContainer_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 09.02.2022.
//  Copyright © 2022 Max. All rights reserved.
//

//protocol QuoteCardRepositoryDIContainer_CN {
//    var quoteCardRepository: QuoteCardGateway_CN { get }
//}
//
//protocol NotificationsRepositoryDIContainer_CN {
//    var notificationsRepository: NotificationGateway_CN { get }
//}

protocol GatewaysRepositoryDIContainerProtocol_CN {
    var quoteCard: QuoteCardGateway_CN { get }
    var notification: NotificationGateway_CN { get }
}


final class GatewaysRepositoryDIContainer_CN: GatewaysRepositoryDIContainerProtocol_CN {
    
    let quoteCard: QuoteCardGateway_CN
    let notification: NotificationGateway_CN
    
    init(quoteCard: QuoteCardGateway_CN,
         notification: NotificationGateway_CN) {
        self.quoteCard = quoteCard
        self.notification = notification
    }
    
    static func createQuoteCardRepository() -> QuoteCardGateway_CN {
        let network = QuoteCardNetworkRepository()
        let localStorage = QuoteCardPersistenceRepository()
        let repo = QuoteCardRepository_CN(network: network,
                                          localStorage: localStorage)
        return repo
    }
    
    static func createNotificationRepository() -> NotificationGateway_CN {
        let network = NotificationNetworkRepository_CN()
        let localStorage = NotificationPersistenceRepository_CN()
        let localPushNotificationService = LocalPushNotificationsService_CN()
        let repo = NotificationRepository_CN(network: network,
                                             localStorage: localStorage,
                                             localPushNotificatiosnService: localPushNotificationService)
        return repo
    }
    
}
