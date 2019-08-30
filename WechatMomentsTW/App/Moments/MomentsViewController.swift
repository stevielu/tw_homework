//
//  MomentsViewController.swift
//  WechatMomentsTW
//
//  Created by wei lu on 27/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import UIKit
import Model
import RXNetworkPlatform
import RxSwift
import RxCocoa

class MomentsViewController: TWBaseTVC {
    private var userServices: Model.UserCaseProvider!
    private var tweetServices: Model.TweetCaseProvider!
    private var viewModel: MomentsViewModel!
    
    let test:UILabel = UILabel()
    
    override func didLoadHandle() {
        self.setup()
        self.bindViewModel()
    }
    
    override func configureView() {
        if(self.tableView == nil){
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        }
        
        self.view.addSubview(self.tableView!)
        
    }
    
    private func setup(){
        self.userServices = RXNetworkPlatform.UserCaseProvider()
        self.tweetServices = RXNetworkPlatform.TweetCaseProvider()
        self.viewModel = MomentsViewModel(scences: self.userServices.makeUseCase(), tweet: tweetServices.makeTweetCase())
    }
    
    private func bindViewModel() {
        
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapVoid().asDriverOnError()
        let input = MomentsViewModel.Input(appearTrigger: viewWillAppear)
        
        let output = viewModel.transform(input: input)
        
        output.user.drive(userBinding).disposed(by: self.disposeBag)
    }
    
    var userBinding: UIBindingObserver<MomentsViewController, User> {
        return UIBindingObserver(UIElement: self, binding: { (vc, user) in
            print(user.nick)
        })
    }
}
