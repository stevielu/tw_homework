//
//  Cache.swift
//  RXNetworkPlatform
//
//  Created by wei lu on 24/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import RxSwift
protocol DefaultCache {
    associatedtype T
    func save(object: T,withPath path:String) -> Completable
    func fetch(withPath path: String) -> Maybe<T>
}

final class TWCache<T>:DefaultCache{
    
    private let cacheScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "com.TWWechat.Network.Cache.queue")
    private var cache = NSCache<AnyObject, AnyObject>()
    
    
    func save(object: T,withPath path:String) -> Completable {
        return Completable.create { (observer) -> Disposable in
            self.cache.setObject(object as AnyObject, forKey: path as AnyObject)
            
            observer(.completed)
            return Disposables.create()
            }.subscribeOn(cacheScheduler)
    }
    
    func fetch(withPath path: String) -> Maybe<T> {
        return Maybe<T>.create { (observer) -> Disposable in
            guard let object = self.cache.object(forKey: path as AnyObject) as? T else {
                observer(.completed)
                return Disposables.create()
            }
            observer(MaybeEvent<T>.success(object))
            return Disposables.create()
            }.subscribeOn(cacheScheduler)
    }
    
    
}
