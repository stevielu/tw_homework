//
//  CommentsTableViewCell.swift
//  WechatMomentsTW
//
//  Created by wei lu on 1/09/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import UIKit
import SnapKit
import Model
import RxCocoa

final class CommentsTableViewCell:DefaultCellView{
    
    override func makeUI() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.detailLabel)
        
        self.titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        self.detailLabel.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        self.detailLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        DispatchQueue.main.async {
            self.titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.snp.left)
                make.top.equalTo(self.snp.top)
                make.bottom.equalTo(self.snp.bottom)
                make.right.equalTo(self.detailLabel.snp.left)
            }
            
            self.detailLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.titleLabel.snp.right)
                make.top.equalTo(self.snp.top)
                make.right.equalTo(self.snp.right)
                make.bottom.equalTo(self.snp.bottom)
            }
            
            self.updateUI()
        }
        
    }
    
}
