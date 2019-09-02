//
//  TweetsCellViewModel.swift
//  WechatMomentsTW
//
//  Created by wei lu on 31/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import UIKit
import RxSwift
import Model
import RxCocoa

class TweetCellViewModel: BaseTableViewCellViewModel {
    let tweet: Tweet
    let photosUrl = BehaviorRelay<[PhotoGroup]?>(value: nil)
    
    init(with model:Tweet) {
        self.tweet = model
        super.init()
        self.title.accept(model.sender?.nick)
        self.detail.accept(model.content)
        self.imageUrl.accept(model.sender?.avatar)
        self.photosUrl.accept(model.images)
    }
}
