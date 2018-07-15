//
//  UIViewController+LYUNavigationBar.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/13.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar{
    
    private struct  AssociatedKeys{
        static var kLYUBackgroundViewKey = "kLYUBackgroundViewKey"
        static var kLYUBackgroundImageViewKey = "kLYUBackgroundImageViewKey"
        static var kLYUBackgroundImageKey = "kLYUBackgroundImageKey"
    }
    
    var backgroundView:UIView?
    {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kLYUBackgroundViewKey) as? UIView
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kLYUBackgroundViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var backgroundImageView:UIImageView?{
        get{
           return objc_getAssociatedObject(self, &AssociatedKeys.kLYUBackgroundImageViewKey) as? UIImageView
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kLYUBackgroundImageViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var backgroundImage:UIImage? {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kLYUBackgroundImageKey) as? UIImage
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kLYUBackgroundImageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置导航栏的背景图片
    func lyu_setBackgroundImage(img:UIImage){
        self.backgroundView?.removeFromSuperview();
        self.backgroundView = nil;
        if(self.backgroundImageView == nil){
            self.setBackgroundImage(img, for: .default);
            if(self.subviews.count > 0){
                self.backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: LYUNavigationBarConfig.navBarBottom))
                self.backgroundImageView?.autoresizingMask = .flexibleWidth
                self.subviews.first?.insertSubview(self.backgroundImageView!, at: 0);
            }
        }else{
            
        }
        self.backgroundImage = img;
        self.backgroundImageView?.image = img;
    }
    
    /// 设置导航栏背景颜色
    func  lyu_setBackgroundColor(color:UIColor){
        self.backgroundImageView?.removeFromSuperview()
        self.backgroundImageView = nil;
        self.backgroundImage = nil;
        if(self.backgroundView == nil){
            self.setBackgroundImage(color.trans2Image(), for: .default)
            self.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: LYUNavigationBarConfig.navBarBottom))
            self.backgroundView?.autoresizingMask = .flexibleWidth;
            self.subviews.first?.insertSubview(self.backgroundView!, at: 0)
        }
        self.backgroundView?.backgroundColor = color;
    }
    
    func lyu_setBackgroundAlpha(alpha:CGFloat){
        let barBackgroundView = self.subviews.first;
        if #available(iOS 11.0, *) {
            for v in (barBackgroundView?.subviews)!
            {
                v.alpha = alpha;
            }
        }else{
            barBackgroundView?.alpha = alpha;
        }
        
    }
    
    /// 设置导航栏所有的BarButtonItem的透明度
    func lyu_setItemAlpha(alpha:CGFloat, hasSystemBackIndicator:Bool){
        for view in self.subviews{
            if(hasSystemBackIndicator == true){//// _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
                let _UIBarBackgroundClass = "_UIBarBackground".toClass;
                if(_UIBarBackgroundClass != nil){
                    if(view.isKind(of: _UIBarBackgroundClass!) == false){
                        view.alpha = alpha;
                    }
                }
                
                let _UINavigationBarBackground = "_UINavigationBarBackground".toClass;
                if(_UINavigationBarBackground != nil){
                    if(view.isKind(of: _UINavigationBarBackground!) == false){
                        view.alpha = alpha;
                    }
                }
            }else{
                // 这里如果不做判断的话，会显示 backIndicatorImage
                if(view.isKind(of: "_UINavigationBarBackIndicatorView".toClass!) == false){
                    let _UIBarBackgroundClass = "_UIBarBackground".toClass;
                    if(_UIBarBackgroundClass != nil){
                        if(view.isKind(of: _UIBarBackgroundClass!) == false){
                            view.alpha = alpha;
                        }
                    }
                
                 let _UINavigationBarBackground = "_UINavigationBarBackground".toClass
                    if(_UINavigationBarBackground != nil){
                        if(view.isKind(of: _UINavigationBarBackground!) == false){
                            view.alpha = alpha;
                        }
                    }
                
                
                
                }
                
                
                
                
                
            }
        }
    }
    /// 设置导航栏在垂直方向上的偏移
    var  lyu_setTranslationY:CGFloat
    {
        get{
            return self.transform.ty;
        }
        set{
            self.transform.translatedBy(x: 0, y: newValue);
        }
    }
}


extension UIViewController
{
    private struct AssociatedKeys {
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
                let isRootViewController:Bool = (self.navigationController?.viewControllers.first == self)
                
                if(self.pushToCurrentVCFinished == true || isRootViewController == true || self.pushToNextVCFinished == false){
//                    self.navigationController
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










