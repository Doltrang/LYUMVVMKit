//
//  LYUNavigationBar.swift
//  LYURouter
//
//  Created by 吕陈强 on 2018/7/12.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

class LYUNavigationBarConfig: UIView {
    
    private struct AssociatedKeys {
        static var kLYUWidely = "kLYUWidely"
        static var kLYUWhitelist = "kLYUWhitelist"
        static var kLYUBlacklist  = "kLYUBlacklist"
        static var kDefaultNavBarBarTintColor = "kDefaultNavBarBarTintColor"
        static var kDefaultNavBarBackgroundImage = "kDefaultNavBarBackgroundImage"
        static var kDefaultNavBarTintColor = "kDefaultNavBarTintColor"
        static var kDefaultNavBarTitleColor = "kDefaultNavBarTitleColor"
        static var kDefaultStatusBarStyle = "kDefaultStatusBarStyle"
        static var kDefaultNavBarShadowImageHidden = "kDefaultNavBarShadowImageHidden"
        static var kDefaultNavBarBackgroundAlpha = "kDefaultNavBarBackgroundAlpha"
    }
    /// 自定义导航栏的使用规则(广泛使用)
    static func lyu_widely(){
        self.isLocalUsed = false;
    }
    /// 当前使用
    static var isLocalUsed:Bool
    {
        get{
            return  objc_getAssociatedObject(self, &AssociatedKeys.kLYUWidely) as? Bool ?? false;
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kLYUWidely, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// 设置控制器导航栏的白名单(isLocalUsed 为true时 生效)
    static var lyu_whitelist:[String] {
        get{
           return objc_getAssociatedObject(self, &AssociatedKeys.kLYUWhitelist) as? [String] ?? [String]()
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kLYUWhitelist, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
     /// 设置控制器导航栏的白名单(isLocalUsed 为false时 生效)
    static var lyu_blacklist:[String] {
        get{
           return objc_getAssociatedObject(self, &AssociatedKeys.kLYUBlacklist) as? [String] ?? [String]()
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kLYUBlacklist, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// 设置导航栏默认的背景颜色 默认为白色
    static var defaultNavBarBarTintColor:UIColor {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kDefaultNavBarBarTintColor) as? UIColor ?? UIColor.white;
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kDefaultNavBarBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置默认的背景图片
    static var defaultNavBarBackgroundImage:UIImage {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kDefaultNavBarBackgroundImage) as? UIImage ?? UIImage.createImage(color: UIColor.white, size: CGSize(width: self.screenWidth, height: self.screenHeight))
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kDefaultNavBarBackgroundImage, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 导航栏所有按钮的默认颜色
    static var defaultNavBarTintColor:UIColor{
        get{
           return objc_getAssociatedObject(self, &AssociatedKeys.kDefaultNavBarTintColor) as? UIColor ?? UIColor.white
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kDefaultNavBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    /// 设置导航栏的按钮的颜色
    static var defaultNavBarTitleColor:UIColor {
        get{
           return objc_getAssociatedObject(self, &AssociatedKeys.kDefaultNavBarTitleColor) as? UIColor ?? UIColor.black
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kDefaultNavBarTitleColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置导航栏的默认状态
    static var defaultStatusBarStyle:UIStatusBarStyle{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kDefaultStatusBarStyle) as? UIStatusBarStyle ?? .default;
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kDefaultStatusBarStyle, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// 设置导航栏的底线是否隐藏
    static var defaultNavBarShadowImageHidden:Bool {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kDefaultNavBarShadowImageHidden) as? Bool ?? true;
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kDefaultNavBarShadowImageHidden, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 这是导航栏的背景透明度
    static var defaultNavBarBackgroundAlpha:CGFloat{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kDefaultNavBarBackgroundAlpha) as? CGFloat ?? 1;
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kDefaultNavBarBackgroundAlpha, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// 检查当前的导航栏是否需要更新
    static func needUpdateNavigationBar(vc:UIViewController) -> Bool{
        if(self.isLocalUsed){
            return self.lyu_whitelist.contains(vc.className);
        }else{
            return self.lyu_blacklist.contains(vc.className);
        }
    }

    

    
}

// MARK:基础判断设置属性以及高度等
extension LYUNavigationBarConfig
{
    /// 是否是iPhoneX
    static var isIphoneX:Bool = {
        var systemInfo = utsname()
        uname(&systemInfo);
        let machine = systemInfo.machine
        let mirror = Mirror(reflecting: machine)
        var identifier = ""
        for child in mirror.children {
            let value = child.value
            
            if let value = value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }
        if(identifier == "i386" || identifier == "x86_64"){
            return (UIScreen.main.bounds.size.equalTo(CGSize(width: 375, height: 812)) || UIScreen.main.bounds.size.equalTo(CGSize(width: 812, height: 375)))
        }
        return (identifier == "iPhone10,3" || identifier == "iPhone10,6");
    }()
    
    /// 返回导航栏的高度
    static var navBarBottom:CGFloat = {
        return LYUNavigationBarConfig.isIphoneX ? 88:64;
    }()
    
    /// 返回tabbar的高度
    static var tabBarHeight:CGFloat = {
        return LYUNavigationBarConfig.isIphoneX ? 83:49;
    }()
    
    /// 返回屏幕的宽度
    static var screenWidth:CGFloat = {
        return UIScreen.main.bounds.size.width;
    }()
    
    /// 返回屏幕的高度
    static var screenHeight:CGFloat = {
        return UIScreen.main.bounds.size.height;
    }()
    
}
