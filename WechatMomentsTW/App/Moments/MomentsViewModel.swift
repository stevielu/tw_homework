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

final class MomentsViewModel:TWBaseViewModel,ViewModelType{
    struct Input {
        let appearTrigger: Driver<Void>
        let headerRefresh: Driver<Void>
    }
    
    struct Output {
        let moments: Driver<MomentsItemViewModel>
        let pullRefresh: Driver<MomentsItemViewModel>
    }
    
    private let userScence: UsersCase
    private let tweetScence: TweetCase
    

    var endHeaderRefreshing: Driver<Bool>!
   
    
    init(scences: UsersCase,tweet:TweetCase) {
        self.userScence = scences
        self.tweetScence = tweet
    }
    
    func transform(input: Input) -> Output {
        
        
        
        let user = self.userScence.fetch(UserId: TWGlobalValue.shareInstance.uid ?? "").asObservable()
        let tweets = self.tweetScence.fetchTweets(UserId: TWGlobalValue.shareInstance.uid ?? "").asObservable()

        let model = Observable.zip(user,tweets) { (user,tweets) -> MomentsItemViewModel in
            return MomentsItemViewModel(with: user, tweets: tweets)
            }.asDriverOnError()
        
        let headerRefreshData = input.headerRefresh.flatMapLatest{
            return model
        }
        

        
        let moments = input.appearTrigger.flatMapLatest{
            return model
        }

        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }
       
        
        return Output(moments: moments, pullRefresh: headerRefreshData)
    }
}

