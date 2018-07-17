//
//  UIView+Core.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/22.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    /// 设置部分圆角(绝对布局)
    ///
    /// - Parameters:
    ///   - corners: 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
    ///   - radii: 需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
    func addRoundedCorners(corners:UIRectCorner = .allCorners, radii:CGSize,rect:CGRect ){
        let rounded = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        self.layer.mask = shape
    }
    
    
    
    
    
    
    
    
    
    
    
}
