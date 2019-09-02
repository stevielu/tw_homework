//
//  CommentsCellViewModel.swift
//  WechatMomentsTW
//
//  Created by wei lu on 1/09/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import RxSwift
import Model
import RxCocoa

class CommentsCellViewModel: BaseTableViewCellViewModel {
    let comments: Comments
    
    init(with model:Comments) {
        self.comments = model
        super.init()
        self.title.accept("\(model.sender?.nick ?? "Anonymous"): ")
        self.detail.accept(model.content)
    }
}
