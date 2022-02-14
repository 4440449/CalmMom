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
    func viewWillAppear()
    func menuButtonTapped()
    var quoteCards: Publisher<[QuoteCard_CN]> { get }
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
    
    init(
        quoteCardRepository: QuoteCardGateway_CN,
         router: MainRouterProtocol_CN) {
//         quoteCards: [QuoteCard_CN]) {
        self.quoteCardRepository = quoteCardRepository
//        self.quoteCards.value = quoteCards
        self.router = router
    }
    
    // MARK: - State
    
    var quoteCards = Publisher(value: [QuoteCard_CN]())
    var isLoading = Publisher(value: Loading_CN.false)
    
    
    // MARK: - Private state
    
    private var quoteTask: Task<Void, Error>? {
        willSet {
            self.quoteTask?.cancel()
        }
    }
    
    
    // MARK: - Interface impl
    
    func viewDidLoad() {
        let state = quoteCardRepository.getState()
        quoteCards.value = state.quoteCards.value
        
        state.quoteCards.subscribe(observer: self) { cards in
            self.quoteCards.value = cards
    }
//        state.quoteCards.notify()
//        quoteCards.notify()
//        isLoading.value = .true
//        quoteTask = Task {
//            let result = await quoteCardRepository.fetch()
//            self.quoteCard.value = result
//            self.isLoading.value = .false
//        }
    }
    
    func viewWillAppear() {
            //updateQuotesCards
    }
    
    func menuButtonTapped() {
        router.menuButtonTapped()
    }
    
    
    func likeButtonTapped(cellWithIndex index: Int) {
//        UIImageWriteToSavedPhotosAlbum(quoteCard.value[index].image, nil, nil, nil)
//        quoteTask = Task {
//            do {
//                var quoteCard = self.quoteCards.value[index]
//                quoteCard.isFavorite = true
//                try await self.quoteCardRepository.saveFavorite(quoteCard)
//                self.quoteCards.value[index].isFavorite = true
//            } catch let error {
//                print("error == \(error)")
////                let errorMessage = self.errorHandler.handle(error)
////                self.error.value = errorMessage
//            }
//        }
        
        switch quoteCards.value[index].isFavorite {
        case false:
            quoteTask = Task {
                do {
                    var quoteCard = self.quoteCards.value[index]
                    quoteCard.isFavorite = true
                    try await self.quoteCardRepository.saveFavorite(quoteCard)
                    self.quoteCards.value[index].isFavorite = true
                } catch let error {
                    print(error)
//                    let errorMessage = self.errorHandler.handle(error)
//                    self.error.value = errorMessage
                }
            }
        case true:
            quoteTask = Task {
                do {
                    var quoteCard = self.quoteCards.value[index]
                    quoteCard.isFavorite = false
                    try await self.quoteCardRepository.deleteFavorite(quoteCard)
                    self.quoteCards.value[index].isFavorite = false
//                    self.quoteCards.value = result
                } catch let error {
                    print(error)
//                    let errorMessage = self.errorHandler.handle(error)
//                    self.error.value = errorMessage
                }
            }
        }
        
        
    }
    
    func shareButtonTapped(cellWithIndex index: Int) {
        let quoteCard = quoteCards.value[index]
        guard let quoteCardImage = textToImage(drawText: quoteCard.quote,
                                               inImage: quoteCard.image) else {
            return
        }
        router.shareButtonTapped(with: quoteCardImage)
    }
    
    
    // MARK: - Private
    
    // To extension UIImage
    private func textToImage(drawText text: String,
                             inImage image: UIImage) -> UIImage? {
        print("image.size == \(image.size)")
        print("UIScreen.main.bounds == \(UIScreen.main.bounds)")
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 18)!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
//        paragraphStyle.lineBreakMode = .byTruncatingTail
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size,
                                               false,
                                               scale)
        let textFontAttributes: [NSAttributedString.Key : Any] = [
            .font: textFont,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
            ]
        image.draw(in: CGRect(origin: CGPoint.zero,
                              size: image.size))
        let edgeOffset: CGFloat = 20
        let point = CGPoint(x: edgeOffset,
                            y: image.size.height / 2)
        let size = CGSize(width: image.size.width - (edgeOffset * 2),
                          height: image.size.height)
        let rect = CGRect(origin: point,
                          size: size)
        text.draw(in: rect,
                  withAttributes: textFontAttributes)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return newImage
    }
    
}

