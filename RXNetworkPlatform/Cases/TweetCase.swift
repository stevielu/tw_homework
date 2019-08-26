//
//  TweetCase.swift
//  RXNetworkPlatform
//
//  Created by wei lu on 25/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import Model
import RxSwift

final class TweetCase<Cache>:Model.TweetCase where Cache:DefaultCache{
    
    private let network: TweetsNetwork
    private let cache: Cache
    
    init(network: TweetsNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }
    
    func fetchTweets(UserId uid: String) -> Observable<[Tweet]> {
        return self.network.fetchTweets(userId: uid)
    }
    
    func fetchTweetImage(ImageUrl url: String) -> Observable<Data> {
        let fetchPhoto = cache.fetch(withPath: url).asObservable()
        fetchPhoto.subscribe{ maybe in
            switch maybe{
            case .completed:
                
            case .next(_):
                <#code#>
            case .error(_):
                <#code#>
            }
        }
    }
    
    
}
