//
//  TweetCaseProvider.swift
//  RXNetworkPlatform
//
//  Created by wei lu on 27/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import Model

public final class TweetCaseProvider: Model.TweetCaseProvider {
    
    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makeTweetCase() -> Model.TweetCase {
        return TweetCase(network: networkProvider.makeTweetsNetworkProvider(),
                            cache: ImageService.shareInstance.cache)
    }
}

