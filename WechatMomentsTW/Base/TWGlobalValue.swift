//
//  TWGlobalValue.swift
//  WechatMomentsTW
//
//  Created by stevie on 2019/8/27.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
final class TWGlobalValue: BaseObject {
    static let shareInstance:TWGlobalValue = TWGlobalValue()
    var uid:String?
    
    enum GlobalValueKeys:String {
        case UserId
        //add more here, token etc...
    }
    
    override init() {
        self.uid = TWKeychain.sharedInstance.readValueForString(key: GlobalValueKeys.UserId.rawValue)
    }
    
    //Keychain or NSUserDefaults
    public func config(){
       TWKeychain.sharedInstance.addValueForString(content: "jsmith", key: GlobalValueKeys.UserId.rawValue)
        //add more here, token etc...
    }
    
    public func save(){
        TWKeychain.sharedInstance.addValueForString(content: self.uid, key: GlobalValueKeys.UserId.rawValue)
        //add more here, token etc...
    }
    
    public func clear(){
        self.uid = nil
    }
    
}
