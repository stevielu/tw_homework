//
//  MomentsViewModel.swift
//  WechatMomentsTW
//
//  Created by stevie on 2019/8/27.
//  Copyright © 2019 vcon. All rights reserved.
//

import Foundation
final class MomentsViewModel:ViewModelType{
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: MomentsViewModel.Input) -> MomentsViewModel.Output {
        
    }
    
    private let useCase: PostsUseCase
    private let navigator: PostsNavigator
    
    init(useCase: PostsUseCase, navigator: PostsNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
}
