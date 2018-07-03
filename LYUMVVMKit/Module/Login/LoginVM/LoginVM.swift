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
  
}


extension LoginVM:LYUViewModelType
{

    typealias Input = LoginInput
    typealias Output  = LoginOutput
    
    
    struct LoginInput {
        //用户名验证结果
        let validatedUsername: Driver<ValidationResult>
        
        //密码验证结果
        let validatedPassword: Driver<ValidationResult>
        
        //再次输入密码验证结果
        let validatedPasswordRepeated: Driver<ValidationResult>
        
        //注册按钮是否可用
        let signupEnabled: Driver<Bool>
        
        //注册结果
        let signupResult: Driver<Bool>
        
        init(username: Driver<String>,
             password: Driver<String>,
             repeatedPassword: Driver<String>,
             loginTaps: Signal<Void>){
            
            
            validatedUsername = username.flatMapLatest({ (username) in
                return LYULoginService.validateUsername(username).asDriver(onErrorJustReturn: .failed(message: "服务器发生错误"))
            })
            
            validatedPassword = password.map({ (password) in
                return LYULoginService.validatePassword(password);
            })
            
            validatedPasswordRepeated = Driver.combineLatest(password,repeatedPassword) { pwd,repwd  in
                 LYULoginService.validateRepeatedPassword(pwd, repeatedPassword: repwd)
            }
            
            signupEnabled = Driver.combineLatest(
                validatedUsername,
                validatedPassword,
                validatedPasswordRepeated
            ) { username, password, repeatPassword in
                username.isValid && password.isValid && repeatPassword.isValid
                }
                .distinctUntilChanged()
            
            
            //获取最新的用户名和密码
            let usernameAndPassword = Driver.combineLatest(username,password) {
                (username: $0, password: $1)}
            
            signupResult = loginTaps.withLatestFrom(usernameAndPassword).flatMapLatest({ pair in
                return LYULoginNetworkService.signup(pair.username, password: pair.password).asDriver(onErrorJustReturn: false);
            })
            
        }
    }
    
    struct LoginOutput {
        
    }
    
    
    
    
    
    func transform(input: LoginVM.LoginInput) -> LoginVM.LoginOutput {
        
        return LoginOutput()
    }
}

