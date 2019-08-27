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
    func save(object: T,withPath path:String)
    func fetch(withPath path: String) -> Observable<T>
}

final class TWCache<T>:DefaultCache{
    
    private let cacheScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "com.TWWechat.Network.Cache.queue")
    private var cache = NSCache<AnyObject, AnyObject>()
    
//    enum ReadStrategy {
//        case ReadOnly//read cache only
//        case ReadFirst//read cache first,and save it depends on if empty in cache
//        case WriteFirst//save cache each request
//    }
    
    func save(object: T,withPath path:String) {
        self.cache.setObject(object as AnyObject, forKey: path as AnyObject)
    }
    
    func fetch(withPath path: String) -> Observable<T> {
        return Observable<T>.create { (observer) -> Disposable in
            guard let object = self.cache.object(forKey: path as AnyObject) as? T else {
                observer.on(.completed)
                return Disposables.create()
            }
            observer.on(.next(object))
            return Disposables.create()
            }.subscribeOn(cacheScheduler)
    }
    
    
}
