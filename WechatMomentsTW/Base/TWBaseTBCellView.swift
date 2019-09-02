//
//  TWBaseTBCellView.swift
//  WechatMomentsTW
//
//  Created by wei lu on 31/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import UIKit

class TWBaseCellView:UITableViewCell{
    var selectionColor: UIColor? {
        didSet {
            setSelected(isSelected, animated: true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    // Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutMargins = UIEdgeInsets.zero
        makeUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        backgroundColor = selected ? selectionColor : .clear
    }
    
    func makeUI() {
        layer.masksToBounds = true
        selectionStyle = .none
        backgroundColor = .clear
        
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
}
