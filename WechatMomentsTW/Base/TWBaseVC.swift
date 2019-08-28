//
//  TWBaseVC.swift
//  WechatMomentsTW
//
//  Created by wei lu on 27/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class TWBaseVC: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.didLoadHandle()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
        self.willApperHandle()
    }
    
    func didLoadHandle(){
        
    }
    
    func willApperHandle(){
        
    }
    
    func configureView(){
        
    }
    
}
