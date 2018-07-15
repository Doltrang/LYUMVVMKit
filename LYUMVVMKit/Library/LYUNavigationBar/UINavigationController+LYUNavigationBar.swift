//
//  UINavigationController+LYUNavigationBar.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/14.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation

extension UINavigationController{
    static var lyuPopDuration = 0.12;
    static var lyuPopDisplayCount = 0.0;
    var lyuPopProgress:CGFloat{
        return CGFloat(min(60*UINavigationController.lyuPopDuration, UINavigationController.lyuPopDisplayCount))
    }
    
    static var lyuPushDuration : CGFloat = 0.10;
    static var lyuPushDisplayCount:CGFloat  = 0.0;
    var lyuPushProgress:CGFloat{
        let all = 60*UINavigationController.lyuPushDuration;
        let current = min(all, UINavigationController.lyuPushDisplayCount)
        return current/all;
    }
    
    
    open override var preferredStatusBarStyle: UIStatusBarStyle
        {
        return self.topViewController!.statusBarStyle
    }
    
    func setNeedsNavigationBarUpdateForBarBackgroundImage(backgroundImage:UIImage){
      
        
        
    }
    
    
    
    
    
    
    
    
}
