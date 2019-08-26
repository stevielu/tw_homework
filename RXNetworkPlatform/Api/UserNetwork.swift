//
//  UserNetwork.swift
//  RXNetworkPlatform
//
//  Created by stevie on 2019/8/23.
//  Copyright © 2019 vcon. All rights reserved.
//

import Model
import RxSwift

public final class UserNetwork{
    private let network:Network<User>
    
    init(network:Network<User>) {
        self.network = network
    }
    
    public func fetchUser(userId:String) -> Observable<User>{
        return self.network.getItem("user", itemId: userId)
    }
    
    public func fetchUsers() -> Observable<[User]>{
        return self.network.getItems("user")
    }
}
