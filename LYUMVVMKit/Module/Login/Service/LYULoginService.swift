//
//  LYUHomeService.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/3.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import RxSwift

class LYULoginService:NSObject {
    //密码最少位数
  static let minPasswordCount = 6
    
    
    //验证用户名
  class  func validateUsername(_ username: String) -> Observable<ValidationResult> {
        //判断用户名是否为空
        if username.isEmpty {
            return .just(.empty)
        }
        //判断用户名是否只有数字和字母
        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .just(.failed(message: "用户名只能包含数字和字母"))
        }
        
        return LYULoginNetworkService.usernameAvailable(username).map({ (available) -> ValidationResult in
            //根据查询情况返回不同的验证结果
            if available {
                return .ok(message: "用户名可用")
            } else {
                return .failed(message: "用户名已存在")
            }
        }).startWith(.validating);
    
    }
    
    //验证密码
   class func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        
        //判断密码是否为空
        if numberOfCharacters == 0 {
            return .empty
        }
        
        //判断密码位数
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "密码至少需要 \(minPasswordCount) 个字符")
        }
        
        //返回验证成功的结果
        return .ok(message: "密码有效")
    }
    
    
    //验证二次输入的密码
   class func validateRepeatedPassword(_ password: String, repeatedPassword: String)
        -> ValidationResult {
            //判断密码是否为空
            if repeatedPassword.count == 0 {
                return .empty
            }
            
            //判断两次输入的密码是否一致
            if repeatedPassword == password {
                return .ok(message: "密码有效")
            } else {
                return .failed(message: "两次输入的密码不一致")
            }
    }
    
    
    
    
}
