//
//  LYULoginService.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/3.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LYULoginNetworkService: NSObject {
    /// 验证用户名
    class func usernameAvailable(_ username:String) -> Observable<Bool>{
        return LYUHomeNetTool.rx.request(.data(type: .ios, size: 20, index: 1)).asObservable().map({ (response) -> Bool in
            return response.statusCode == 200
        }).catchErrorJustReturn(false);
    }
    
    //注册用户
  class  func signup(_ username: String, password: String) -> Observable<Bool> {
        //这里我们没有真正去发起请求，而是模拟这个操作（平均每3次有1次失败）
        let signupResult = arc4random() % 3 == 0 ? false : true
        return Observable.just(signupResult)
            .delay(1.5, scheduler: MainScheduler.instance) //结果延迟1.5秒返回
    }

}







import UIKit

//验证结果和信息的枚举
enum ValidationResult {
    case validating  //正在验证中s
    case empty  //输入为空
    case ok(message: String) //验证通过
    case failed(message: String)  //验证失败
}

//扩展ValidationResult，对应不同的验证结果返回验证是成功还是失败
extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

//扩展ValidationResult，对应不同的验证结果返回不同的文字描述
extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case .validating:
            return "正在验证..."
        case .empty:
            return ""
        case let .ok(message):
            return message
        case let .failed(message):
            return message
        }
    }
}

//扩展ValidationResult，对应不同的验证结果返回不同的文字颜色
extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .validating:
            return UIColor.gray
        case .empty:
            return UIColor.black
        case .ok:
            return UIColor(red: 0/255, green: 130/255, blue: 0/255, alpha: 1)
        case .failed:
            return UIColor.red
        }
    }
}
