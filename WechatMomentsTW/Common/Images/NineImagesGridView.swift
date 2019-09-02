//
//  NineImagesGridView.swift
//  WechatMomentsTW
//
//  Created by wei lu on 1/09/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import UIKit
import SnapKit

enum GridImagesErro : Error {
    case OutScope(Count: Int)
}

class NineImagesGridView:UIView{
    var photos:[UIImageView]!

    var colums:Int = 3
    
    var leftMargin:CGFloat = 0.0
    
    var rightMargin:CGFloat = 0.0
    
    var topMargin:CGFloat = 0.0
    
    var bottomMargin:CGFloat = 0.0
    
    var columsMargin:CGFloat = 5.0
    
    var rowMargin:CGFloat = 5.0
    
    var unitViewHeight:CGFloat = 100.0
    
    private var index = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func updatePhotos(withImgs:[UIImageView]){
        self.photos = withImgs
        self.flush()
        self.makeUI()
    }
    
    func setupImageGrid(img:UIImage) throws -> Void{
        guard self.index <= photos.count - 1 || self.index > 8 else{
            throw GridImagesErro.OutScope(Count: self.index)
        }
        
        photos[index].image = img
        index += 1
    }
    
    func makeUI(){
        DispatchQueue.main.async {
            if self.photos.count == 1{
                if(self.photos[0].added == true){return}
                self.addSubview(self.photos[0])
                self.photos[0].backgroundColor = UIColor.gray
                self.photos[0].snp.makeConstraints { (make) in
                    make.left.equalTo(self.snp.left)
                    make.right.equalTo(self.snp.right)
                    make.top.equalTo(self.snp.top)
                    make.bottom.equalTo(self.snp.bottom)
                }
            }else{
                var row = 0,colum = 0
                let itemW = self.frame.width/CGFloat(self.colums)

                for (index,item) in self.photos.enumerated() {
                    if item.added == true {return}
                    
                    self.addSubview(item)
                    item.added = true
                    item.backgroundColor = UIColor.gray
                    
                    row = index / self.colums
                    colum = index % self.colums
                    
                    item.snp.makeConstraints { (make) in
                        make.leading.equalTo(self).offset(self.leftMargin + (self.columsMargin + itemW) * CGFloat(colum))
                        make.top.equalTo(self).offset((self.topMargin + (self.unitViewHeight + self.rowMargin) * CGFloat(row) ))
                        make.width.equalTo(itemW)
                        make.height.equalTo(self.unitViewHeight)
                    }
                }
            }
            
            self.updateUI()
        }
        
    }
    
    func updateUI() {
        layoutIfNeeded()
    }
    
    func flush(){
        for item in self.subviews{
            item.removeFromSuperview()
        }
    }
    
}

extension UIView{
    private struct AddedAssociatedKeys {
        static var added = "Added"
    }
    
    var added: Bool! {
        get {
            guard let currentValue = objc_getAssociatedObject(self, &AddedAssociatedKeys.added) as? Bool else {
                return false
            }
            return currentValue
        }
        
        set(value) {
            objc_setAssociatedObject(self, &AddedAssociatedKeys.added, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
