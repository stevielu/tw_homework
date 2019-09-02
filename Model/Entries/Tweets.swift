//
//  Tweets.swift
//  Model
//
//  Created by stevie on 2019/8/23.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation

public struct TweetList:Codable {
    public let list:[Tweet]
    
    public init(from decoder: Decoder) throws {
        var topContainer = try decoder.unkeyedContainer()
        list = try topContainer.decode([Tweet].self)
    }
}

public struct Tweet:Codable {
    public let content:String?
    public let images:[PhotoGroup]?
    public let comments:[Comments]?
    public let sender:User?
    public let unknown: String?
}

public struct Comments:Codable {
    public let sender:User?
    public let content:String?
}

public struct PhotoGroup:Codable{
    public let url:String?
}

