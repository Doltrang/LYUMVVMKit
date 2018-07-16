//
//  UINavigationBar+Extension.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/16.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
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
    ///     open var titleTextAttributes: [NSAttributedStringKey : Any]?
    
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
    
    /// 调取方法的交换
    static func loadSwizzledMethod(){
        
        DispatchQueue.once(token: "loadSwizzledMethodUINavigationBar") {
       let sel =     #selector(setter: UINavigationBar.titleTextAttributes)
            UINavigationBar.swizzleMethod(originalSelector: sel, swizzledSelector: #selector(lyu_setTitleTextAttributes));
        }
        
    }

    
    @objc fileprivate func lyu_setTitleTextAttributes(titleTextAttributes:[NSAttributedStringKey : Any]?){
        
        LLog(titleTextAttributes);
        guard let titleTextAttributes = titleTextAttributes else {
            return;
        }
        var newTitleTextAttributes = titleTextAttributes;
        if(self.titleTextAttributes == nil){
            self.lyu_setTitleTextAttributes(titleTextAttributes: newTitleTextAttributes);
            return;
        }
        
        let titleColor = self.titleTextAttributes![NSAttributedStringKey.foregroundColor] as? UIColor;
        if(newTitleTextAttributes.keys.contains(NSAttributedStringKey.foregroundColor) && titleColor != nil){
            newTitleTextAttributes[NSAttributedStringKey.foregroundColor] = titleColor;
        }
       
        self.lyu_setTitleTextAttributes(titleTextAttributes: newTitleTextAttributes);
        
    }
    
    
}
