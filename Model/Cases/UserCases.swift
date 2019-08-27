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
    func fetch(UserId uid:String) -> Observable<User>
    func userAvatar(ImageUrl url:String ) -> Observable<Data>
    func userProfile(ImageUrl url:String ) -> Observable<Data>
}
