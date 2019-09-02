//
//  TWArray.swift
//  WechatMomentsTW
//
//  Created by wei lu on 2/09/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation

extension Array{
    func returnArrayObjects(Size value:Int) -> Array<Element>{
        var copy = self.map { $0 }
        var new = [Element]()
        for i in 0..<value {
            if copy.isEmpty { break }
            let element = copy[i]
            new.append(element)
        }
        return new
    }
    
    
}
