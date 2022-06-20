//
//  QuoteCardNetworkRepositoryProtocol_CN.swift
//  CalmingNotifications
//
//  Created by Maxim on 15.01.2022.
//  Copyright © 2022 Max. All rights reserved.
//


import BabyNet
import Foundation


protocol QuoteCardNetworkRepositoryProtocol_CN {
    func fetch(callback: @escaping (Result<[QuoteCardNetworkEntity_CN], Error>) -> (),
               taskProgressCallback: ((Progress) -> ())?) -> URLSessionTask?
}


final class QuoteCardNetworkRepository: QuoteCardNetworkRepositoryProtocol_CN {
    
    // MARK: - Dependencies
    private let client: BabyNetRepositoryProtocol
    private let apiKey: String
    
    // MARK: - Init
    init(client: BabyNetRepositoryProtocol,
         apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    // MARK: - Interface
    
    func fetch(callback: @escaping (Result<[QuoteCardNetworkEntity_CN], Error>) -> (),
               taskProgressCallback: ((Progress) -> ())?) -> URLSessionTask? {
        let url = BabyNetURL(scheme: .https,
                             host: "sruvmguuadrikxjglriw.supabase.co",
                             path: "/rest/v1/QuoteCard",
                             endPoint: nil)
        let request = BabyNetRequest(method: .get,
                                     header: ["apiKey" : apiKey],
                                     body: nil)
        let session = BabyNetSession.default
        let decoderType = [QuoteCardNetworkEntity_CN].self
        return client.connect(url: url,
                              request: request,
                              session: session,
                              decoderType: decoderType,
                              responseCallback: callback,
                              taskProgressCallback: taskProgressCallback)
    }
    
    
    deinit {
//        print("QuoteCardNetworkRepository is deinit -------- ")
    }
}

//
// 'https://sruvmguuadrikxjglriw.supabase.co/rest/v1/QuoteCard?select=id' \


