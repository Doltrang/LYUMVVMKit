//
//  UIButton+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    
    //MARK:-取消高亮状态
    override open var isHighlighted: Bool {
        set{
            
        }
        get {
            return false
        }
    }
    static var eventTag = 0;
    
    /// EZSwiftExtensions: Convenience constructor for UIButton.
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, target: AnyObject, action: Selector) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    }
    
    /// EZSwiftExtensions: Set a background color for the button.
    public func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }

    
    /// 设置相机的权限
    public func  setNeedsCameraPermission(){
//        UIButton.swizzleMethod(originalSelector: #selector(UIButton.point(inside:with:)), swizzledSelector: #selector(lyu_point(inside:with:)));
        
         UIButton.swizzleMethod(originalSelector: #selector(UIButton.sendAction(_:to:for:)), swizzledSelector: #selector(lyu_sendAction(_:to:for:)));
    }
    @objc open func lyu_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        UIButton.eventTag += 1;
        if(UIButton.eventTag % 3 > 1){
            super.sendAction(action, to: target, for: event);
        }else{
            LLog("----");
            
        }
    }
}
