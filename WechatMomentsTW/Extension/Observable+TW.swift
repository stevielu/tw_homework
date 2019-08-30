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
    func mapVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    func asDriverOnError() -> Driver<E> {
        return asDriver { error in
            return Driver.empty()
        }
    }
}
