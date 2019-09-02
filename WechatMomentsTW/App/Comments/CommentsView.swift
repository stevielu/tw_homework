//
//  CommentsView.swift
//  WechatMomentsTW
//
//  Created by wei lu on 1/09/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import UIKit
import Model

final class CommentsView:UITableView{
    public var commentsSource:[Comments]?
    
    override init(frame: CGRect, style: UITableView.Style) {
        self.commentsSource = nil
        
        super.init(frame: frame, style: style)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(){
        self.register(CommentsTableViewCell.self, forCellReuseIdentifier: "CommentsCell")
        self.rowHeight = UITableView.automaticDimension
    }
    
    private func bindViewModel() {
    }
    
    public func addSource(data:[Comments]?){
        self.commentsSource = data
        self.reloadData()
        
    }
    
    
}
