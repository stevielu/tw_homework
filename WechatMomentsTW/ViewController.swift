//
//  ViewController.swift
//  WechatMomentsTW
//
//  Created by stevie on 2019/8/23.
//  Copyright © 2019 vcon. All rights reserved.
//

import UIKit
import RxSwift
import Model
import RXNetworkPlatform

class ViewController: UIViewController {
    private let services: Model.TweetCaseProvider = RXNetworkPlatform.TweetCaseProvider()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }
}

