//
//  ImageEncodable.swift
//  RXNetworkPlatform
//
//  Created by wei lu on 24/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation


protocol UrlStoreable {
    var url:String{get}
}

protocol DataStore {
    associatedtype StoreAttr: UrlStoreable

    func retrieveStore() -> StoreAttr
}
