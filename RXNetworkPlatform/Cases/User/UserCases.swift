//
//  UserCases.swift
//  RXNetworkPlatform
//
//  Created by stevie on 2019/8/27.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import Model
import RxSwift

final class UserCase<Cache>:Model.UsersCase where Cache:DefaultCache,Cache.T == Data{
    
    private let network: UserNetwork
    private let cache: Cache
    
    init(network: UserNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }
    
    func fetch(UserId uid:String) -> Observable<User> {
        return self.network.fetchUser(userId: uid)
    }
    
    func userAvatar(ImageUrl url: String) -> Observable<Data> {
        return self.getPhoto(url: url)
    }
    
    func userProfile(ImageUrl url: String) -> Observable<Data> {
        return self.getPhoto(url: url)
    }
    
    private func getPhoto(url:String)-> Observable<Data>{
        let local = cache.fetch(withPath: url).asObservable()
        
        //此处还需重构，将cache封装到服务中，根据缓存策略进行依赖注入到网络请求中，来进行对应操作
        let fetchNetwork = self.network.fetchImg(absoluteImgUrl: url).map{data -> (Data) in
        self.cache.save(object: data, withPath: url)
            return data
        }
        return local.concat(fetchNetwork)
    }
    
}
