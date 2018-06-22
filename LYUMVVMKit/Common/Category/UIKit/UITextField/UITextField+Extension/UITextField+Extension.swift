//
//  UITextField+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit
enum UITextFieldPaddingDirection {
    case left
    case right
}
extension UITextField{
    
    //MARK:-设置暂位文字的颜色
    var placeholderColor:UIColor {
        get{
            let color =   self.value(forKeyPath: "_placeholderLabel.textColor")
            if(color == nil){
                return UIColor.white;
            }
            return color as! UIColor;
        }
        set{
            self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    //MARK:-设置暂位文字的字体
    var placeholderFont:UIFont{
        get{
            let font =   self.value(forKeyPath: "_placeholderLabel.font")
            if(font == nil){
                return UIFont.systemFont(ofSize: 14);
            }
            return font as! UIFont;
        }
        set{
            self.setValue(newValue, forKeyPath: "_placeholderLabel.font")
        }
        
    }
    
    
    /// 设置视图的偏移量
    ///
    /// - Parameters:
    ///   - width: 宽度
    ///   - direction: 方向
    func setPadding(with width: CGFloat, direction: UITextFieldPaddingDirection) {
        let frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        let paddingView = UIView(frame: frame)
        switch direction {
        case .left:
            self.leftViewMode = .always
            self.leftView = paddingView
        default:
            self.rightViewMode = .always
            self.rightView = paddingView
        }
    }
    
}
