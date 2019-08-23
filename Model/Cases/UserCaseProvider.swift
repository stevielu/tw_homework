//
//  UserCaseProvider.swift
//  Model
//
//  Created by stevie on 2019/8/23.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
public protocol UserCaseProvider {
    func makePostsUseCase() -> UsersCase
}
