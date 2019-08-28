//
//  Observable+TW.swift
//  WechatMomentsTW
//
//  Created by wei lu on 28/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
