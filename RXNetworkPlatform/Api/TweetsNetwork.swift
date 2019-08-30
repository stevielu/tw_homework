//
//  TweetsNetwork.swift
//  RXNetworkPlatform
//
//  Created by wei lu on 24/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import Model
import RxSwift

public final class TweetsNetwork{
    private let network:Network<Tweet>
    
    init(network:Network<Tweet>) {
        self.network = network
    }
    
    public func fetchTweets(userId:String) -> Observable<[Tweet]>{
        return self.network.getItems("user/\(userId)/tweets")
            .map{
                $0.filter{$0.sender == nil || ($0.content == nil && $0.images == nil)}
            }
    }
    
    public func fetchImg(absoluteImgUrl:String) -> Observable<Data>{
        return self.network.getImage(absoluteImgUrl)
    }
}
