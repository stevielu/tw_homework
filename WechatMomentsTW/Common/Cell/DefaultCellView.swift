//
//  DefaultCellView.swift
//  WechatMomentsTW
//
//  Created by wei lu on 31/08/19.
//  Copyright © 2019 vcon. All rights reserved.
//

import UIKit
import SnapKit

class DefaultCellView: TWBaseCellView {
    lazy var leftImageView: UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor.darkGray
        
        return view
    }()
    
   
    lazy var titleLabel: TWLabel = {
        let view = TWLabel()
        view.font = UIFont.titleFont
        view.textColor = UIColor.titleBlue
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        return view
    }()
    
    lazy var detailLabel: TWLabel = {
        let view = TWLabel()
        view.font = UIFont.subtitleFont
        view.textColor = UIColor.subTitleBlack
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        return view
    }()
    
    lazy var secondDetailLabel: TWLabel = {
        let view = TWLabel()
        view.font = UIFont.subtitleBoldFont
        
        return view
    }()
    
 
    
    override func makeUI() {
        super.makeUI()
       
    }
    
    func bind(to viewModel: BaseTableViewCellViewModel) {
        viewModel.title.asDriver().drive(titleLabel.rx.text).dispose()
        viewModel.title.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(titleLabel.rx.isHidden).dispose()

        viewModel.detail.asDriver().drive(detailLabel.rx.text).dispose()
        viewModel.detail.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(detailLabel.rx.isHidden).dispose()
        
       
//        
//        viewModel.image.asDriver().filterNil()
//            .drive(leftImageView.rx.image).disposed(by: rx.disposeBag)
//        
//        viewModel.imageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
//            .drive(leftImageView.rx.imageURL).disposed(by: rx.disposeBag)
//        
//        viewModel.imageUrl.asDriver().filterNil()
//            .drive(onNext: { [weak self] (url) in
//                self?.leftImageView.hero.id = url
//            }).disposed(by: rx.disposeBag)
    }
}
