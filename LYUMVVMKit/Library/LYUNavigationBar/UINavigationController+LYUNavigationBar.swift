//
//  UINavigationController+LYUNavigationBar.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/14.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation

extension UINavigationController{
    fileprivate typealias Animations = (UITransitionContextViewControllerKey) -> (UITransitionContextViewControllerKey)
    
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
        
        if(LYUNavigationBarConfig.needUpdateNavigationBar(vc: fromVC)){
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
 
    @objc static func loadNavigationSwizzledMethod(){
        
        DispatchQueue.once(token: "UINavigationController_LYUNavigationBar_loadSwizzledMethod") {
           
            let _updateInteractiveTransition = Selector("_update(_ :)");
//                #selector("update(_ :)".toSelector);
            UINavigationController.swizzleMethod(originalSelector: _updateInteractiveTransition, swizzledSelector: #selector(lyu_updateInteractiveTransition(_:)));
            
            /// exchange pushViewController
            UINavigationController.swizzleMethod(originalSelector: #selector(UINavigationController.pushViewController(_:animated:)), swizzledSelector: #selector(lyu_pushViewController(_:animated:)));
            
           ///exchange popToViewController
            UINavigationController.swizzleMethod(originalSelector: #selector(UINavigationController.popToViewController(_:animated:)), swizzledSelector: #selector(lyu_popToViewController(_:animated:)));
            
            
            ///exchange popToRootViewControllerAnimated
            UINavigationController.swizzleMethod(originalSelector: #selector(UINavigationController.popToRootViewController(animated:)), swizzledSelector: #selector(lyu_popToRootViewController(animated:)));
        }
        
        
        
    }
    
    @objc func lyu_dealInteractionChanges(context:UIViewControllerTransitionCoordinatorContext){
        
        var animations:Animations? = {[weak self] key  in
            let vc = context.viewController(forKey: key)
            let curColor = vc?.navBarBarTintColor
            let curAlpha = vc?.navBarBackgroundAlpha
            self?.setNeedsNavigationBarUpdateForBarTintColor(barTintColor: curColor!)
        self?.setNeedsNavigationBarUpdateForBarBackgroundAlpha(barBackgroundAlpha: curAlpha!)
            return key;
        }
     
        if(context.isCancelled){
            UIView.animate(withDuration: 0) {
               _ =  animations!(UITransitionContextViewControllerKey.from);
            }
        }else{
            let finishDuration:TimeInterval = context.transitionDuration *  TimeInterval((1.0 - context.percentComplete))
            UIView.animate(withDuration: finishDuration) {
                  _ =  animations!(UITransitionContextViewControllerKey.from);
            }
        }
        
    }
    
    @objc func lyu_updateInteractiveTransition(_ percentComplete:CGFloat){
        let fromVC = self.topViewController?.transitionCoordinator?.viewController(forKey: .from);
        let toVC = self.topViewController?.transitionCoordinator?.viewController(forKey: .to);
        self.updateNavigationBar(fromVC: fromVC!, toVC: toVC!, progress: percentComplete);
        self.lyu_updateInteractiveTransition(percentComplete)
    }
    
    @objc func lyu_pushViewController(_ viewController: UIViewController, animated: Bool){
        
    }
    
    @objc func lyu_popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?{
      self.setNeedsNavigationBarUpdateForTitleColor(titleColor: viewController.navBarTitleColor)
        self.setNeedsNavigationBarUpdateForTintColor(tintColor: viewController.navBarTitleColor)
        var  displayLink:CADisplayLink? = CADisplayLink(target: self, selector: #selector(popNeedDisplay));
        
        displayLink?.add(to: RunLoop.main, forMode: .commonModes);
        CATransaction.setCompletionBlock {
            displayLink?.invalidate()
            displayLink = nil
            UINavigationController.lyuPopDisplayCount = 0;
        };
        
        
        CATransaction.setAnimationDuration(UINavigationController.lyuPopDuration);
        CATransaction.begin()
        let vcs = self.lyu_popToViewController(viewController, animated: animated);
        return vcs;
        
    }
    
    @objc func lyu_popToRootViewController(animated: Bool) -> [UIViewController]? {
        var  displayLink:CADisplayLink? = CADisplayLink(target: self, selector: #selector(popNeedDisplay));
        
        displayLink?.add(to: RunLoop.main, forMode: .commonModes);
        CATransaction.setCompletionBlock {
            displayLink?.invalidate()
            displayLink = nil
            UINavigationController.lyuPopDisplayCount = 0;
        };
        
        
        CATransaction.setAnimationDuration(UINavigationController.lyuPopDuration);
        CATransaction.begin()
        let vcs = self.lyu_popToRootViewController(animated: animated)
        return vcs;
    }
   
    
    @objc fileprivate func popNeedDisplay(){
        if(self.topViewController != nil && self.topViewController?.transitionCoordinator != nil){
            UINavigationController.lyuPopDisplayCount += 1;
            let popProgress = self.lyuPopProgress;
            let fromVC = self.topViewController!.transitionCoordinator!.viewController(forKey: .from);
            let toVC = self.topViewController?.transitionCoordinator?.viewController(forKey: .to);
            
            self.updateNavigationBar(fromVC: fromVC!, toVC: toVC!, progress: popProgress);
        }
    }
    
   @objc fileprivate func pushNeedDisplay(){
    if(self.topViewController != nil && self.topViewController?.transitionCoordinator != nil){
        UINavigationController.lyuPushDisplayCount += 1;
        let popProgress = self.lyuPushProgress;
        let fromVC = self.topViewController!.transitionCoordinator!.viewController(forKey: .from);
        let toVC = self.topViewController?.transitionCoordinator?.viewController(forKey: .to);
        
        self.updateNavigationBar(fromVC: fromVC!, toVC: toVC!, progress: popProgress);
    }
    }
    
    
    
}







