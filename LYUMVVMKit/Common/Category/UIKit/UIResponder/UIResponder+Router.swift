//
//  UIResponder+Router.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/5/2.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit


extension UIResponder
{
    
    func router(eventName:String, userinfo:[String:AnyHashable] = [String:AnyHashable]()){
        /// 事件继续传递
        self.next?.router(eventName: eventName, userinfo: userinfo);
        debugPrint("self:====\(self) eventName:====\(eventName) userinfo:====\(userinfo)")
        
     
        
    }
    
    
    
    
}
