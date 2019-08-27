//
//  UserCaseProvider.swift
//  RXNetworkPlatform
//
//  Created by stevie on 2019/8/27.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import Model
public final class UserCaseProvider: Model.UserCaseProvider {
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makePostsUseCase() -> UsersCase {
        return UserCase(network: networkProvider.makeUserNetworkProvider(), cache: ImageService.shareInstance.cache)
    }
}
