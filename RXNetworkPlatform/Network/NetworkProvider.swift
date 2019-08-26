//
//  NetworkProvider.swift
//  RXNetworkPlatform
//
//  Created by stevie on 2019/8/23.
//  Copyright © 2019 vcon. All rights reserved.
//

import Model

final class NetworkProvider{
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "http://thoughtworks-ios.herokuapp.com/"
    }
    
    public func makeUserNetworkProvider() -> UserNetwork{
        let network = Network<User>(apiEndpoint)
        return UserNetwork(network: network)
    }
    
    public func makeTweetsNetworkProvider() -> TweetsNetwork{
        let network = Network<Tweet>(apiEndpoint)
        return TweetsNetwork(network: network)
    }
}
