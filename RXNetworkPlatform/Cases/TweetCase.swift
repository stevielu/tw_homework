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
        
        //此处还需重构，将cache封装到服务中，根据缓存策略进行依赖注入到网络请求中，来进行对应操作
        let fetchNetwork = self.network.fetchImg(absoluteImgUrl: url).map{data -> (Data) in
            self.cache.save(object: data, withPath: url)
            return data
        }
        return local.concat(fetchNetwork)
    }
    
    
}
