//
//  UserCases.swift
//  Model
//
//  Created by stevie on 2019/8/23.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import RxSwift
public protocol UsersCase {
    func get() -> Observable<[User]>
}
