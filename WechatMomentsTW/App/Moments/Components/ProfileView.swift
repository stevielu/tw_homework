//
//  ProfileView.swift
//  WechatMomentsTW
//
//  Created by wei lu on 31/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import UIKit
import SnapKit

class UserProfileView:UIView{
    lazy var backgroudImg:UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.backgroundColor = .white
        self.addSubview(view)
        
        return view
    }()
    
    lazy var avatar:UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.backgroundColor = UIColor.gray
        
        //self.layer.cornerRadius = CornerRaiusValue
        self.clipsToBounds = false
        self.addSubview(view)
        
        return view
    }()
    
    lazy var name:UILabel = {
        let view = UILabel()
        view.textColor = UIColor.titleBlack
        view.font = UIFont.titleBoldFont
        self.addSubview(view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        
        self.backgroudImg.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.avatar.snp.makeConstraints { (make) in
            make.size.equalTo(AvatarSize)
            make.bottom.equalTo(self.snp.bottom).offset(AvatarSize/4)
            make.right.equalTo(self.snp.right).offset(RightPadding)
        }
        
        self.name.snp.makeConstraints { (make) in
            make.right.equalTo(self.avatar.snp.left).offset(RightPadding)
            make.height.equalTo(LabelHeight)
            make.bottom.equalTo(self.snp.bottom)
        }
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.avatar.roundCorners([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: CornerRaiusValue)
    }
}
