//
//  LoginVM.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import Moya
import NSObject_Rx
import RxCocoa
import RxSwift


 let disposeBag = DisposeBag()
class LoginVM: BaseViewModel {
    // 记录当前的索引值
    var index: Int = 1
    
   
}


extension LoginVM:LYUViewModelType
{

    typealias Input = LoginInput
    typealias Output  = LoginOutput
    
    
    struct LoginInput {
        
    }
    
    struct LoginOutput {
        
    }
    
    func transform(input: LoginVM.LoginInput) -> LoginVM.LoginOutput {
        
        return LoginOutput()
    }
}

