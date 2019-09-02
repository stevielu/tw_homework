//
//  BaseTableViewCellViewModel.swift
//  WechatMomentsTW
//
//  Created by wei lu on 30/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseTableViewCellViewModel: NSObject {
    let title = BehaviorRelay<String?>(value: nil)
    let detail = BehaviorRelay<String?>(value: nil)
    let secondDetail = BehaviorRelay<String?>(value: nil)
    let imageUrl = BehaviorRelay<String?>(value: nil)
    let badge = BehaviorRelay<UIImage?>(value: nil)
    let badgeColor = BehaviorRelay<UIColor?>(value: nil)
    
}
