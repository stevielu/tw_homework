//
//  Tweets.swift
//  Model
//
//  Created by stevie on 2019/8/23.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation

struct TweetList:Codable {
    public let list:[Tweet]
    
    init(from decoder: Decoder) throws {
        var topContainer = try decoder.unkeyedContainer()
        list = try topContainer.decode([Tweet].self)
    }
    
    
}

struct Tweet:Codable {
    public let content:String?
    public let images:[ImagesKeys]?
    public let comments:Comments?
    public let sender:User?
    public let unknown: String?
    
    struct Comments:Codable {
        public let sender:User?
        public let content:String?
    }
    
    
}

struct ImagesKeys:Codable {
    public let url:String?
}


