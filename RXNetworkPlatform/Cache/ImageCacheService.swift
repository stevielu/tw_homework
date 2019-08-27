//
//  ImageCacheService.swift
//  RXNetworkPlatform
//
//  Created by stevie on 2019/8/27.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
class ImageService: NSObject {
    static let shareInstance:ImageService = ImageService()
    public let cache = TWCache<Data>()
}
