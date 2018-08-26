//
//  LoginForeVM.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/8/26.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import NSObject_Rx
import RxCocoa
import RxSwift

class LoginForeVM {
 
    func transform( skip:Signal<Void>,register:Signal<Void>, login:Signal<Void>)  {
        skip.asObservable().subscribe { (event) in
            LLog(event)
            UIApplication.shared.keyWindow?.rootViewController = LYUMainVC()
            }.disposed(by: disposeBag)
        
        login.asObservable().subscribe(onNext: { (event) in
            LYURouter.open(vcClassName: "LoginVC")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag);
        
        
        register.asObservable().subscribe(onNext: { (event) in
            LYURouter.open(vc: LoginVC());
        }).disposed(by: disposeBag)
        
    }
    
}
