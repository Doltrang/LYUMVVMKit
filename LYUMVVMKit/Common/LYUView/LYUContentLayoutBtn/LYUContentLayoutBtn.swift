//
//  LYUContentLayoutBtn.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/24.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

enum LYUButtonLayoutStyle {
    case ImageLeftContentLeft     /// 图片居左 文字配合间距  整体水平方向靠左
    case ImageRightContentLeft  /// 图片居右 文字配合间距 整体水平方向靠左
    case ImageLeftContentRight  /// 图片居左 文字配合间距 整体水平方向靠右
    case ImageRightContentRight /// 图片居右 文字配合间距 整体水平方向靠右
    case ImageLeftContentCenter  /// 图片居左 文字配合间距 整体水平方向居中
    case ImageRightContentCenter /// 图片居右 文字配合间距 整体水平方向居中
    
    case ImageTopContentTop/// 图片居上  文字配合间距 整体垂直方向居上
    case ImageBottomContentBottom /// 图片居下 文字配合间距 整体垂直方向居底
    case ImageTopContentCenter   /// 图片居上  文字配合间距 整体垂直方向居中
    case ImageBottomContentCenter /// 图片居下 文字配合间距 整体垂直方向居中
}

class LYUButton: UIButton {
    private(set) fileprivate var imgSize:CGSize = CGSize.zero;
    private(set) fileprivate var style:LYUButtonLayoutStyle = .ImageLeftContentLeft;
    private(set) fileprivate var space:CGFloat = 0.0;
    
    /// layout btn subviews
    ///
    /// - Parameters:
    ///   - style: layout style
    ///   - imgSize: img size
    ///   - space: space
    func layoutContent(style:LYUButtonLayoutStyle, imgSize:CGSize, space:CGFloat){
        self.style = style;
        self.imgSize = imgSize;
        self.space = space;
        /// 强制当前loop刷新UI
        setNeedsLayout();
        layoutIfNeeded();
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews();
        guard let lab = self.titleLabel, let imgV = self.imageView else {
            return;
        }
        let size = self.frame.size;
        
        switch self.style {
        case .ImageLeftContentLeft:
            imgV.frame = CGRect(x: 0, y: (size.height - self.imgSize.height)/2.0, width: self.imgSize.width, height: self.imgSize.height);
            lab.frame = CGRect(x: self.imgSize.width + self.space, y: 0, width: (size.width - self.imgSize.width - self.space), height: size.height);
            break;
            
        case .ImageLeftContentCenter:
            let labRect = lab.textRect(forBounds: CGRect(x: 0, y: 0, width: size.width - self.imgSize.width - self.space, height: size.height), limitedToNumberOfLines: lab.numberOfLines)
            imgV.frame = CGRect(x: (size.width - self.imgSize.width - self.space - labRect.size.width)/2.0, y: (size.height - self.imgSize.height)/2.0, width: self.imgSize.width, height: self.imgSize.height);
            lab.frame = CGRect(x: imgV.frame.origin.x + self.imgSize.width + self.space, y: 0, width: (labRect.size.width), height: size.height);
            
            break;
        case .ImageLeftContentRight:
            let labRect = lab.textRect(forBounds: CGRect(x: 0, y: 0, width: size.width - self.imgSize.width - self.space, height: size.height), limitedToNumberOfLines: lab.numberOfLines)
            lab.frame = CGRect(x: size.width - labRect.size.width, y: 0, width: labRect.size.width, height: size.height);
            
            imgV.frame = CGRect(x: size.width - self.imgSize.width - self.space - labRect.size.width, y: (size.height - self.imgSize.height)/2.0, width: self.imgSize.width, height: self.imgSize.height);
            
            break;
            
        case .ImageRightContentLeft:
            let labRect = lab.textRect(forBounds: CGRect(x: 0, y: 0, width: size.width - self.imgSize.width - self.space, height: size.height), limitedToNumberOfLines: lab.numberOfLines)
            lab.frame = CGRect(x: 0, y: 0, width: labRect.size.width, height: size.height)
            imgV.frame = CGRect(x: labRect.size.width + self.space, y: (size.height - self.imgSize.height)/2.0, width: self.imgSize.width, height: self.imgSize.height);
            
            break;
        case .ImageRightContentCenter:
            let labRect = lab.textRect(forBounds: CGRect(x: 0, y: 0, width: size.width - self.imgSize.width - self.space, height: size.height), limitedToNumberOfLines: lab.numberOfLines)
            lab.frame = CGRect(x:  (size.width - self.imgSize.width - self.space - labRect.size.width)/2.0, y: 0, width: labRect.size.width, height: size.height)
            imgV.frame = CGRect(x: lab.frame.origin.x + labRect.size.width + self.space, y: (size.height - self.imgSize.height)/2.0, width: self.imgSize.width, height: self.imgSize.height);
            break;
            
        case .ImageRightContentRight:
            imgV.frame = CGRect(x: size.width - self.imgSize.width, y: (size.height - self.imgSize.height)/2.0, width: self.imgSize.width, height: self.imgSize.height);
            lab.frame = CGRect(x: 0, y: 0, width: (size.width - self.imgSize.width - self.space), height: size.height);
            break;
            
            
        case .ImageTopContentTop:
            let labRect = lab.textRect(forBounds: CGRect(x: 0, y: 0, width: size.width - self.imgSize.width - self.space, height: size.height), limitedToNumberOfLines: lab.numberOfLines)
            imgV.frame = CGRect(x: (size.width - self.imgSize.width)/2.0, y: 0, width: self.imgSize.width, height: self.imgSize.height)
            lab.frame = CGRect(x: 0, y: imgSize.height+space, width: size.width, height: labRect.size.height)
            break;
            
        case .ImageTopContentCenter:
            let labRect = lab.textRect(forBounds: CGRect(x: 0, y: 0, width: size.width - self.imgSize.width - self.space, height: size.height - self.space - self.imgSize.height), limitedToNumberOfLines: lab.numberOfLines)
            imgV.frame = CGRect(x: (size.width - self.imgSize.width)/2.0, y: (size.height - labRect.size.height - imgSize.height - space)/2.0, width: self.imgSize.width, height: self.imgSize.height)
            lab.frame = CGRect(x: 0, y: imgV.frame.origin.y + imgSize.height + space, width: size.width, height: labRect.size.height);
            break;
            
            
        case .ImageBottomContentBottom:
            let labRect = lab.textRect(forBounds: CGRect(x: 0, y: 0, width: size.width - self.imgSize.width - self.space, height: size.height), limitedToNumberOfLines: lab.numberOfLines)
            imgV.frame = CGRect(x: (size.width - self.imgSize.width)/2.0, y: size.height - imgSize.height, width: self.imgSize.width, height: self.imgSize.height)
            lab.frame = CGRect(x: 0, y: size.height - labRect.size.height - self.imgSize.height - self.space, width: size.width, height: labRect.size.height)
            
            break;
            
        case .ImageBottomContentCenter:
            let labRect = lab.textRect(forBounds: CGRect(x: 0, y: 0, width: size.width - self.imgSize.width - self.space, height: size.height), limitedToNumberOfLines: lab.numberOfLines);
            lab.frame = CGRect(x: 0, y: (size.height - labRect.size.height - self.imgSize.height - self.space)/2.0, width: size.width, height: labRect.size.height)
            imgV.frame = CGRect(x: (size.width - self.imgSize.width)/2.0, y: lab.frame.origin.y + labRect.size.height + self.space, width: self.imgSize.width, height: self.imgSize.height)
        }
        
    }
    
    
    
}
