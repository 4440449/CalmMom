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
    private let quotes = ["Цель нашей жизни - быть счастливыми",
                          "Жизнь - это то, что происходит с вами, пока вы строите другие планы",
                          "Я думаю, что любознательность к жизни во всех ее аспектах все же является секретом великих творческих людей.",
                          "Жизнь - это не проблема, которую нужно решить, а реальность, которую нужно пережить",
                          "Неисследованная жизнь не стоит того, чтобы жить",
                          "Превратите свои раны в мудрость",
                          "Как я это вижу, если вы хотите радугу, вам нужно примириться с дождем",
                          "Пережить все, что положено судьбой - значит всецело ее принять",
                          "Не соглашайтесь на то, что дает вам жизнь, сделайте жизнь лучше и стройте что-нибудь",
                          "Вы никогда не научитесь многому, слушая, как вы говорите",
                          "Жизнь навязывает вам вещи, которые вы не можете контролировать, но у вас все еще есть выбор, как это пережить",
                          "Жизнь никогда не бывает легкой. Есть работа, которую нужно сделать, и обязательства, которые нужно выполнить, обязательства перед правдой, справедливостью и свободой",
                          " Жизнь, на самом деле, проста, но люди настойчиво ее усложняют",
                          " Жизнь - как вождение велосипеда. Чтобы сохранять равновесие, нужно продолжать двигаться",
                          "Моя мама всегда говорила: жизнь - как коробка шоколадных конфет. Никогда не знаешь, что попадется",
                          " Жизнь - это череда уроков, которые нужно прожить, чтобы понять"]
    
    init(network: QuoteCardNetworkRepositoryProtocol_CN,
         localStorage: QuoteCardPersistenceRepositoryProtocol_CN) {
        self.network = network
        self.localStorage = localStorage
    }
    
    // MARK: - Interface impl
    
    func fetch() async -> [QuoteCard_CN] {
        //sleep(1)
        var cards = [QuoteCard_CN]()
        for i in 0...10 {
            let card = QuoteCard_CN(quote: quotes[i],
                                 image: UIImage(named: "image\(i)")!)
            cards.append(card)
        }
        return cards
    }
}
