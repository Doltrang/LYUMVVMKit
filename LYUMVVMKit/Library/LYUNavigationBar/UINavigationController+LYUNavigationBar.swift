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
        self.navigationBar.lyu_setBackgroundImage(img: backgroundImage);
    }
    
    func setNeedsNavigationBarUpdateForBarTintColor(barTintColor:UIColor){
       self.navigationBar.lyu_setBackgroundColor(color: barTintColor)
    }
    
    func setNeedsNavigationBarUpdateForBarBackgroundAlpha(barBackgroundAlpha:CGFloat){
        self.navigationBar.lyu_setBackgroundAlpha(alpha: barBackgroundAlpha);
    }
    
    func setNeedsNavigationBarUpdateForTintColor(tintColor:UIColor){
        self.navigationBar.tintColor = tintColor;
    }
    
    func setNeedsNavigationBarUpdateForShadowImageHidden(hidden:Bool){
        self.navigationBar.shadowImage = (hidden == true) ? UIColor.black.trans2Image() : nil;
    }
    
    func setNeedsNavigationBarUpdateForTitleColor(titleColor:UIColor){
        var  titleTextAttributes = self.navigationBar.titleTextAttributes;
        if(titleTextAttributes == nil){
            self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:titleColor];
            return;
        }else{
            titleTextAttributes![NSAttributedStringKey.foregroundColor] = titleColor;
            self.navigationBar.titleTextAttributes = titleTextAttributes;
        }
    }
    
    
    func updateNavigationBar(fromVC:UIViewController, toVC:UIViewController, progress:CGFloat){
        /// change navBarBarTintColor
        let fromBarTintColor = fromVC.navBarBarTintColor;
        let toBarTintColor = toVC.navBarBarTintColor;
        let newBarTintColor = fromBarTintColor.toColor(toColor: toBarTintColor, percent: progress);
        
        if(LYUNavigationBarConfig.needUpdateNavigationBar(vc: fromVC) || LYUNavigationBarConfig.needUpdateNavigationBar(vc: toVC)){
            self.setNeedsNavigationBarUpdateForBarTintColor(barTintColor: newBarTintColor)
        }
        
        
        /// change navBarBarTintColor
        
        let fromTintColor = fromVC.navBarTintColor;
        let toTintColor = toVC.navBarTintColor;
        let newTintColor = fromTintColor.toColor(toColor: toTintColor, percent: progress);
        
        if(LYUNavigationBarConfig.needUpdateNavigationBar(vc: fromVC) || LYUNavigationBarConfig.needUpdateNavigationBar(vc: toVC)){
            self.setNeedsNavigationBarUpdateForTintColor(tintColor: newTintColor)
        }
        
        /// change navBarTitleColor（在wr_popToViewController:animated:方法中直接改变标题颜色）
        
        let fromTitleColor = fromVC.navBarTitleColor;
        let toTitleColor = toVC.navBarTitleColor;
        let newTitleColor = fromTitleColor.toColor(toColor: toTitleColor, percent: progress);
           self.setNeedsNavigationBarUpdateForTitleColor(titleColor: newTitleColor)
   
        /// change navBar _UIBarBackground alpha
        let fromBarBackgroundAlpha = fromVC.navBarBackgroundAlpha;
        let toBarBackgroundAlpha = toVC.navBarBackgroundAlpha;
        let newBarBackgroundAlpha = fromBarBackgroundAlpha.toAlpha(toAlpha: toBarBackgroundAlpha, percent: progress)
        self.setNeedsNavigationBarUpdateForBarBackgroundAlpha(barBackgroundAlpha: newBarBackgroundAlpha);
        
        
    }
    
    
}

// MARK:交换方法
extension UINavigationController{
 
    static func loadSwizzledMethod(){
        DispatchQueue.once(token: "UINavigationController_LYUNavigationBar_loadSwizzledMethod") {
           
            let _updateInteractiveTransition = Selector("update(_ :)");
//                #selector("update(_ :)".toSelector);
            UINavigationController.swizzleMethod(originalSelector: _updateInteractiveTransition, swizzledSelector: #selector(lyu_updateInteractiveTransition(_:)));
            
        }
        
        
        
    }
    
    
    @objc func lyu_updateInteractiveTransition(_ percentComplete:CGFloat){
        
    }
}







