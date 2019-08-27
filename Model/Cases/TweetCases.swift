//
//  TweetCases.swift
//  Model
//
//  Created by wei lu on 25/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import RxSwift
public protocol TweetCase {
    func fetchTweets(UserId uid: String) -> Observable<[Tweet]>
    func fetchTweetImage(ImageUrl url:String ) -> Observable<Data>
}
