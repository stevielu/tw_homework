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
//        let avatar:Driver<UIImage>
    }
    
    private let userScence: UsersCase
    private let tweetScence: TweetCase
    init(scences: UsersCase,tweet:TweetCase) {
        self.userScence = scences
        self.tweetScence = tweet
    }
    
    func transform(input: Input) -> Output {
        
        let userInfo = input.appearTrigger.flatMapLatest{
            return self.userScence.fetch(UserId: "jsmith").asDriver{error in
                return Driver.empty()
            }
        }
        
        return Output(user: userInfo)
    }
}
