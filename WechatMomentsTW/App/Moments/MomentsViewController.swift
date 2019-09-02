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
import RxOptional
import SnapKit
import MJRefresh

enum MomentsSection:Int {
    case MyProfile = 0
    case Teewts = 1
    case Count
    case None = 9999
    
    init(section: Int) {
        if let type = MomentsSection(rawValue: section) {
            self = type
        }
        else {
            self = .None
        }
    }
}

final class MomentsViewController: TWBaseTVC {
    private var userServices: Model.UsersCase!
    private var tweetServices: Model.TweetCase!
    private var viewModel: MomentsViewModel!
    private var dataSource:MomentsItemViewModel?
    private var tempDataSource:[Tweet]?
    
    override func didLoadHandle() {
        self.setup()
        self.bindViewModel()
    }
    
    override func configureView() {
        if(self.tableView == nil){
        self.tableView = UITableView(frame: CGRect(), style: .grouped)
        }
        self.tableView?.separatorStyle = .none
        self.view.addSubview(self.tableView!)
        
        self.tableView?.snp.makeConstraints({ (make) in
            if #available(iOS 11.0, *){
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            }else{
                make.top.equalTo(self.topLayoutGuide.snp.top)
            }
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        })
    }
    
    private func setup(){
        self.userServices = RXNetworkPlatform.UserCaseProvider().makeUseCase()
        self.tweetServices = RXNetworkPlatform.TweetCaseProvider().makeTweetCase()
        self.viewModel = MomentsViewModel(scences: self.userServices, tweet: tweetServices)
        
        
        self.tableView?.register(TweetsTableViewCell.self, forCellReuseIdentifier: "TweetCell")
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.rowHeight = UITableView.automaticDimension
        self.tableView?.mj_header = MJRefreshNormalHeader()
        self.tableView?.mj_footer = MJRefreshBackNormalFooter()
    }
    
    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapVoid().asDriverOnError()
        let headerRefresh = self.tableView!.mj_header.rx.refreshing.asDriver()
        let footerRefresh = self.tableView!.mj_footer.rx.refreshing.asDriver()
        let input = MomentsViewModel.Input(appearTrigger: viewWillAppear, headerRefresh: headerRefresh)
        let output = viewModel.transform(input: input)
        

        output.moments.drive(momentsBinding).disposed(by: self.disposeBag)
        
        output.pullRefresh.drive(onNext: { items in
            self.dataSource = items
            self.tempDataSource = items.moments.returnArrayObjects(Size: 5)//retrive 5 elements at most
            if let count  = self.tempDataSource?.count{
                self.dataSource?.moments.removeSubrange(0...count - 1)
            }
            
            self.tableView?.reloadData()
        }).disposed(by: self.disposeBag)
        
        footerRefresh.flatMapLatest{
                return Driver.just(self.dataSource)
            }
            .drive(onNext: { items in
                if let newContents = items?.moments.returnArrayObjects(Size: 5),newContents.count > 0{
                    self.dataSource?.moments.removeSubrange(0...newContents.count - 1)
                    self.tempDataSource?.append(contentsOf: newContents) //retrive 5 elements at most
                    self.tableView?.reloadData()
                }
                
                Driver.just(true).drive(self.tableView!.mj_footer.rx.endRefreshing).disposed(by: self.disposeBag)
            }).disposed(by: self.disposeBag)
        
        viewModel.endHeaderRefreshing
            .drive(self.tableView!.mj_header.rx.endRefreshing)
            .disposed(by: self.disposeBag)
    }
    
    
    var momentsBinding: UIBindingObserver<MomentsViewController, MomentsItemViewModel> {
        return UIBindingObserver(UIElement: self, binding: { (vc, moments) in
            vc.dataSource = moments
            vc.tempDataSource = moments.moments.returnArrayObjects(Size: 5)//retrive 5 elements at most
            if let ds = vc.tempDataSource,ds.count > 0{
                self.dataSource?.moments.removeSubrange(0...ds.count - 1)
            }
            
            vc.tableView?.reloadData()
        })
    }
    
    

    
    //TableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return MomentsSection.Count.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = MomentsSection(section: section)
        switch sectionType {
        case .MyProfile:
            return 1;
        case .Teewts:
            guard let cellContent = self.dataSource else{return 0}
            return self.tempDataSource?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = MomentsSection(section: section)
        switch sectionType {
            case .MyProfile:
                guard let cellContent = self.dataSource else{return UIView()}
                let header = UserProfileView()
                let avatarUrl = BehaviorRelay<String?>(value: cellContent.user.avatar).filterNil().asObservable()
                let profileUrl = BehaviorRelay<String?>(value: cellContent.user.profileImage).filterNil().asObservable()
                
                header.name.text = cellContent.user.nick
                
                avatarUrl.subscribe(onNext: { (Url) in
                    self.userServices.userAvatar(ImageUrl: Url).subscribe(onNext: { (content) in
                        DispatchQueue.main.async {
                            header.avatar.image = UIImage(data: content)
                        }
                    })
                }).disposed(by: self.disposeBag)
                
                profileUrl.subscribe(onNext: { (Url) in
                    self.userServices.userProfile(ImageUrl: Url).subscribe(onNext: { (content) in
                        DispatchQueue.main.async {
                            header.backgroudImg.image = UIImage(data: content)
                        }
                    })
                }, onError: { (error) in
                    header.backgroudImg.image = UIImage(named: "default")
                }).disposed(by: self.disposeBag)

                return header
            case .Teewts:
                return nil
            default:
                return nil
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = MomentsSection(section: section)
        switch sectionType {
            case .MyProfile:
                return 220
            case .Teewts:
                return 20
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = MomentsSection(section: indexPath.section)
        guard let cellContent = self.tempDataSource else{return UITableViewCell()}
        
        switch sectionType {
            case .MyProfile:
                let cell = UITableViewCell()
                cell.separatorInset = UIEdgeInsets.zero
                cell.backgroundColor = UIColor.clear
                return cell
            case .Teewts:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetsTableViewCell else { fatalError("Unexpected Table View Cell") }
                let viewModel = TweetCellViewModel(with: cellContent[indexPath.row])
                cell.bind(to: viewModel, scence: self.tweetServices)
                cell.layoutIfNeeded()
                return cell
            default:
                return UITableViewCell()
        }
    }
}


