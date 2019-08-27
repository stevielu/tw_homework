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
    private var tweet:TweetCase!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tweet = services.makeTweetCase()
        self.test()
        
    }

    func test(){
        
        tweet.fetchTweetImage(ImageUrl: "http://info.thoughtworks.com/rs/thoughtworks2/images/glyph_badge.png").subscribe(onNext: { data in
            DispatchQueue.main.async {
                let imgView = UIImageView(image: UIImage(data: data))
                imgView.frame = self.view.frame
                self.view.addSubview(imgView)
                
                let btn = UIButton()
                btn.backgroundColor = UIColor.blue
                btn.setTitle("Refresh", for: .normal)
                btn.frame = CGRect(x: self.view.frame.width/2, y: self.view.frame.height/2, width: 100, height: 50)
                self.view.addSubview(btn)
                
                btn.addTarget(self, action: #selector(self.fetch(sender:)), for: .touchDown)
            }
            
        }).disposed(by: disposeBag)
        
        
    }
    
    @objc func fetch(sender:UIButton){
        tweet.fetchTweetImage(ImageUrl: "http://info.thoughtworks.com/rs/thoughtworks2/images/glyph_badge.png").subscribe(onNext: { data in
            DispatchQueue.main.async {
                let imgView = UIImageView(image: UIImage(data: data))
                imgView.frame = self.view.frame
                self.view.addSubview(imgView)
            }
            
        }).disposed(by: disposeBag)
    }
}

