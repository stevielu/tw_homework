//
//  ViewModelType.swift
//  WechatMomentsTW
//
//  Created by stevie on 2019/8/27.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
