//
//  TweetsTableViewCell.swift
//  WechatMomentsTW
//
//  Created by wei lu on 31/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import UIKit
import SnapKit
import Model
import RxCocoa

final class TweetsTableViewCell:DefaultCellView{
    
    lazy var grid:NineImagesGridView = {
        let view = NineImagesGridView(frame: CGRect())
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var comments:CommentsView = {
        let view = CommentsView(frame: CGRect(), style: .plain)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func makeUI() {
        self.addSubview(self.leftImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.detailLabel)
        self.addSubview(self.grid)
        self.addSubview(self.comments)
        
        
        
        self.leftImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(LeftPadding)
            make.top.equalTo(self.snp.top).offset(TopPadding)
            make.size.equalTo(SmallAvatarSize)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftImageView.snp.right).offset(LeftPadding)
            make.top.equalTo(self.leftImageView.snp.top)
            make.right.equalTo(self.snp.right).offset(RightPadding)
        }
        
        self.detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.right.equalTo(self.snp.right).offset(RightPadding)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            //make.bottom.equalTo(self.snp.bottom).offset(BottomPadding)
        }
        
        grid.snp.makeConstraints { (make) in
            make.top.equalTo(self.detailLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.detailLabel)
            make.height.equalTo(0)
            //                make.bottom.equalTo(self.comments.snp.top).offset(-5)
        }
       
    }
    
    func bind(to viewModel: BaseTableViewCellViewModel,scence:TweetCase) {
        super.bind(to: viewModel)
        guard let viewModel = viewModel as? TweetCellViewModel else { return }

        let senderAvatar = viewModel.imageUrl.asObservable().filterNil().subscribe(onNext: { (url) in
            return scence.fetchTweetImage(ImageUrl: url).map({ (data) -> UIImage in
                UIImage(data: data)!
            }).subscribe(onNext: { (image) in
                self.leftImageView.image = image
            }).dispose()
            
        })
        
        if let imgArray = viewModel.tweet.images{
            var imgViews = [UIImageView]()
            let rowWdith = ceilf(Float(Float(imgArray.count)/3))
            let rowHigh = (imgArray.count == 1) ? grid.unitViewHeight*2 : CGFloat(rowWdith)*grid.unitViewHeight
            
            //add image placholder
            for _ in 0..<imgArray.count {
                imgViews.append(UIImageView())
            }
            
            grid.snp.remakeConstraints { (make) in
                make.top.equalTo(self.detailLabel.snp.bottom).offset(5)
                make.left.right.equalTo(self.detailLabel)
                make.height.equalTo(rowHigh)
//                make.bottom.equalTo(self.comments.snp.top).offset(-5)
            }
            
            comments.snp.makeConstraints { (make) in
                make.top.equalTo(self.grid.snp.bottom).offset(5)
                make.left.equalTo(self.grid.snp.left)
                make.right.equalTo(self.grid.snp.right)
                make.bottom.equalTo(self.snp.bottom).offset(BottomPadding)
            }
            
            self.grid.updatePhotos(withImgs: imgViews)
            
            //fetch image content
            for imgObj in imgArray{
                let url = BehaviorRelay<String?>(value: imgObj.url).asObservable().filterNil().subscribe(onNext: { (url) in
    
//                    return scence.fetchTweetImage(ImageUrl:url).map({ (data) -> UIImage in
//                        UIImage(data: data)!
//                    }).subscribe(onNext: {(image) in
//                        do{
//                            try view.setupImageGrid(img: image)
//                        }
//                        catch GridImagesErro.OutScope(let cnt){
//                            print("GridImages Outscop: \(cnt)")
//                        }
//    
//                    }).dispose()
    
                })
                

            }
        }
        
        
        //add comments
        
        self.comments.addSource(data: viewModel.tweet.comments)
    }
    
}
extension TweetsTableViewCell:UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.commentsSource?.count ?? 0
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellContent = self.comments.commentsSource else{return UITableViewCell()}

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as? CommentsTableViewCell else { fatalError("Unexpected Table View Cell") }
        let viewModel = CommentsCellViewModel(with: cellContent[indexPath.row])
        cell.bind(to: viewModel)
        
        cell.layoutIfNeeded()
        return cell
    }

}
