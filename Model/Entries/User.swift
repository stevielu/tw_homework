//
//  User.swift
//  Model
//
//  Created by stevie on 2019/8/23.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation


public struct User:Codable {
    
    public let profileImage: String?
    public let avatar: String?
    public let nick: String?
    public let username: String?
    
    //modify properties name
    private enum CodingKeys:String,CodingKey{
        case profileImage = "profile-image"
        case avatar
        case nick
        case username
    }

    public init(profileImage: String,
                avatar: String,
                nick: String,
                username: String) {
        self.profileImage = profileImage
        self.avatar = avatar
        self.nick = nick
        self.username = username
    }
}
