//
//  MomentsViewModel.swift
//  WechatMomentsTW
//
//  Created by stevie on 2019/8/27.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation

import Model
import RxSwift
import RxCocoa

final class MomentsViewModel:ViewModelType{
    struct Input {
        let appearTrigger: Driver<Void>
    }
    
    struct Output {
        let user: Driver<User>
//        let tweet:Driver<Tweet>
        let avatar:Driver<UIImage>
    }
    
    private let userScence: UsersCase
    private let tweetScence: TweetCase
    init(scences: UsersCase,tweet:TweetCase) {
        self.userScence = scences
        self.tweetScence = tweet
    }
    
    func transform(input: Input) -> Output {
        
        let fetchUser = self.userScence.fetch(UserId: "jsmith").asDriverOnError()
        let userInfo = input.appearTrigger.asObservable().concat(fetchUser)
        let avatar = fetchUser.map{ user in
            return self.userScence.userAvatar(ImageUrl: user.avatar ?? "")
        }
//        {
//            return self.userScence.fetch(UserId: "jsmith").asDriverOnError()
//        }
//        let avatar = userInfo.map{ user -> UIImage in
//            return self.userScence.userAvatar(ImageUrl: user.avatar ?? "").map{ content ->UIImage in
//                return UIImage(data: content)!
//            }.asObservable()
//
//        }
        
//            .map{ user -> UserItemViewModel in
//                let avatar = self.userScence.userAvatar(ImageUrl: user.avatar ?? "")
//                let profile = self.userScence.userProfile(ImageUrl: user.profileImage ?? "")
//                return Observable.zip(avatar,profile, resultSelector:UserItemViewModel.finished)
//        }
        return Output(user: userInfo,avatar: avatar)
    }
}

