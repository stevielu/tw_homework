//
//  UserItemViewModel.swift
//  WechatMomentsTW
//
//  Created by wei lu on 28/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import Model

final class UserItemViewModel {
    let avatar:UIImage
    let profile : UIImage
    let user: User
    init (with post:User,avatar:UIImage,profile:UIImage) {
        self.user = post
        self.avatar = avatar
        self.profile = profile
    }
}
