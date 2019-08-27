//
//  TWKeychain.swift
//  WechatMomentsTW
//
//  Created by stevie on 2019/8/27.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import KeychainSwift
class TWKeychain:BaseObject{
    static let sharedInstance:TWKeychain = TWKeychain(Prefix: "TW")
    private let keychain:KeychainSwift
    init(Prefix value:String) {
        self.keychain = KeychainSwift(keyPrefix: value)
    }
    
    public func addValueForString(content:String?,key:String){
        if(content == nil){
            keychain.delete(key)
            return
        }
        
        keychain.set(content!, forKey: key)
    }
    
    public func readValueForString(key:String) -> String?{
        return keychain.get(key)
    }
}
