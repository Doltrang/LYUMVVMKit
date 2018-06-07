//
//  LYUNotificationCenter.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/25.
//  Copyright © 2018年 吕陈强. All rights reserved.
//
import UIKit
import Foundation

class  LYUNotificationCenter: NSObject {
    
    static let shared:LYUNotificationCenter = {
        let tools = LYUNotificationCenter();
        return tools;
    }();
    
    
    //发送通知
    class func postNotification(name: String,object:Any?,userInfo:[AnyHashable : Any]? = nil){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo);
        
    }
    //接收通知
    class func addObserver(observer: Any, selector: Selector, name:String, object: Any?){
        NotificationCenter.default.addObserver(observer, selector: selector, name:NSNotification.Name(rawValue: name), object: object);
    }
    
    //移除通知
    class func removeObserver(observer: Any) {
        NotificationCenter.default.removeObserver(self);
    }
}

