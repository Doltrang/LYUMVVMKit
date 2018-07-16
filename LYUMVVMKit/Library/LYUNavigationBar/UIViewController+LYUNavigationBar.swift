//
//  UIViewController+LYUNavigationBar.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/13.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit



extension UIViewController
{
    private struct AssociatedKeys {
        static var kNavBarBackgroundImage = "kNavBarBackgroundImage"
        static var kNavBarBarTintColor = "kNavBarBarTintColor"
        static var kNavBarBackgroundAlpha = "kNavBarBackgroundAlpha"
        static var kNavBarTintColor = "kNavBarTintColor"
        static var kNavBarTitleColor = "kNavBarTitleColor"
        static var kStatusBarStyle = "kStatusBarStyle"
        static var kNavBarShadowImageHidden = "kNavBarShadowImageHidden"
        static var kPushToCurrentVCFinished = "kPushToCurrentVCFinished"
        static var kPushToNextVCFinished = "kPushToNextVCFinished"
        static var kSystemNavBarBarTintColor = "kSystemNavBarBarTintColor"
        static var kCustomNavBar = "kCustomNavBar"
    }
    
    /// 当前是否完成push状态
    var pushToCurrentVCFinished:Bool {
        get{
          return objc_getAssociatedObject(self, &AssociatedKeys.kPushToCurrentVCFinished) as? Bool ?? false
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kPushToCurrentVCFinished, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// push
    var pushToNextVCFinished:Bool {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kPushToNextVCFinished) as? Bool ?? false
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kPushToNextVCFinished, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// navBarBackgroundImage
    var lyu_navBarBackgroundImage:UIImage{
        get{
           return objc_getAssociatedObject(self, &AssociatedKeys.kNavBarBackgroundImage) as? UIImage ?? LYUNavigationBarConfig.defaultNavBarBackgroundImage
        }
        set{
           objc_setAssociatedObject(self, &AssociatedKeys.kNavBarBackgroundImage, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// 设置导航栏默认的背景颜色 默认为白色
     var navBarBarTintColor:UIColor {
        get{
            var barTintColor = objc_getAssociatedObject(self, &AssociatedKeys.kNavBarBarTintColor) as? UIColor;
            if(!LYUNavigationBarConfig.needUpdateNavigationBar(vc: self)){
                if(self.systemNavBarBarTintColor == nil){
                    barTintColor = self.navigationController?.navigationBar.barTintColor;
                }else{
                    barTintColor = self.systemNavBarBarTintColor;
                }
            }
            
            return barTintColor ?? LYUNavigationBarConfig.defaultNavBarBarTintColor;
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kNavBarBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if(self.customNavBar.isKind(of: UINavigationBar.self)){
                
            }else{
                
                
                if(self.pushToCurrentVCFinished == true || self.isRootViewController == true || self.pushToNextVCFinished == false){
//   [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
                }
            }
            
        }
    }
    
    /// 设置导航栏的透明度
     var navBarBackgroundAlpha:CGFloat {
        get{
          return objc_getAssociatedObject(self, &AssociatedKeys.kNavBarBackgroundAlpha) as? CGFloat ?? 1.0
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kNavBarBackgroundAlpha, newValue, .OBJC_ASSOCIATION_ASSIGN)
            if(self.customNavBar.isKind(of: UINavigationBar.self)){
                
            }else{
                
            }
            
        }
    }
    
    /// 设置导航栏的item颜色
     var navBarTintColor:UIColor {
        get{
           return objc_getAssociatedObject(self, &AssociatedKeys.kNavBarTintColor) as? UIColor ?? UIColor.white
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kNavBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置导航栏的文字颜色
     var navBarTitleColor:UIColor {
        get{
          return objc_getAssociatedObject(self, &AssociatedKeys.kNavBarTitleColor) as? UIColor ?? UIColor.black
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kNavBarTitleColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置状态栏的类型
    var statusBarStyle:UIStatusBarStyle {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kStatusBarStyle) as? UIStatusBarStyle ?? .default;
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kStatusBarStyle, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// 设置导航栏的底线是否隐藏
    var navBarShadowImageHidden:Bool{
        get{
           return objc_getAssociatedObject(self, &AssociatedKeys.kNavBarShadowImageHidden) as? Bool ?? true
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kNavBarShadowImageHidden, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    ///系统导航栏的颜色
    fileprivate var systemNavBarBarTintColor:UIColor? {
        get{
         return objc_getAssociatedObject(self, &AssociatedKeys.kSystemNavBarBarTintColor) as? UIColor
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kSystemNavBarBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置自定义的导航栏
    fileprivate var customNavBar:UIView {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kCustomNavBar) as? UIView ?? UIView()
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kCustomNavBar, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    fileprivate var isRootViewController:Bool{
        
        let rootViewController = self.navigationController?.viewControllers.first;
        if(!(rootViewController!.isKind(of: UITabBarController.self))){
            return rootViewController == self;
        }else{
            let tabBarController = rootViewController as! UITabBarController;
            return tabBarController.viewControllers!.contains(self);
        }
    }
    
}










