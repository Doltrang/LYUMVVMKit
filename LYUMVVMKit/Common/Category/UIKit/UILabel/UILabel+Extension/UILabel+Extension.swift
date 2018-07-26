//
//  UILabel+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    class func createLabel(_ frame: CGRect = CGRect.zero,
                           font: UIFont = UIFont.systemFont(ofSize: 14),
                           textColor: UIColor = UIColor.white,
                           textAlignment: NSTextAlignment = .left,
                           text: String = "") -> UILabel{
        
        let label = UILabel()
        label.frame = frame
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.text = text
        label.isUserInteractionEnabled = true;
        label.lineBreakMode = .byClipping;
        return label
    }
    
    /// 获得文本的高度通过最大的宽度
    ///
    /// - Parameters:
    ///   - width: 文本的最大宽度
    /// - Returns: 文本的最小高度
    func getTextHeight(with width:CGFloat)->CGFloat{
        let rect = self.textRect(forBounds: CGRect(x: 0.0, y: 0.0, width: width, height: CGFloat(MAXFLOAT)), limitedToNumberOfLines: self.numberOfLines);
        return rect.size.height;
    }
    
    /// 通过限制最大的高度获取文本的最小宽度
    ///
    /// - Parameter height: 文本的高度
    /// - Returns: 文本的最小宽度
    func getTextWidth(with height:CGFloat)->CGFloat{
        let rect = self.textRect(forBounds: CGRect(x: 0.0, y: 0.0, width: CGFloat(MAXFLOAT), height: height), limitedToNumberOfLines: self.numberOfLines);
        return rect.size.width;
    }
    
    
}
