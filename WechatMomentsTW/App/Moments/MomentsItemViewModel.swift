//
//  UserItemViewModel.swift
//  WechatMomentsTW
//
//  Created by wei lu on 28/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import Model

final class MomentsItemViewModel {
    let user:User
    var moments : [Tweet]
    init (with owner:User,tweets: [Tweet]) {
        self.user = owner
        self.moments = tweets
    }
}
