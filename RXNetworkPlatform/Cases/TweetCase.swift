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

final class TweetCase<Cache>:Model.TweetCase where Cache:DefaultCache,Cache.T == Data{
    
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
        let local = cache.fetch(withPath: url).asObservable()
        let fetchNetwork = self.network.fetchImg(absoluteImgUrl: url).flatMap {data in
            return self.cache.save(object:data, withPath: url)
                .asObservable()
                .map(Data.self)
                .concat(Observable.just(data))
        }
        return local.concat(fetchNetwork)
    }
    
    
}
