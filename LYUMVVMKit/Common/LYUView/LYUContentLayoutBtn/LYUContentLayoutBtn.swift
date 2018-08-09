//
//  LYUContentLayoutBtn.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/24.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

enum LYUButtonLayoutStyle {
    case none
    case ImageLeftContentStart        /// 图片居左 文字居右 整体水平居左
    case ImageLeftContentCenter      /// 图片居左 文字配合间距 整体水平居中
    case ImageRightContentStart       /// 图片居右 文字配合间距 整体水平居右
    case ImageRightContentCenter    /// 图片局右 文字配合间距 整体水平居中
    case ImageTopContentCenter         /// 图片居上  文字配合间距 整体垂直方向居中
    case ImageBottomContentCenter   /// 图片居下 文字配合间距 整体垂直方向居中
}

class LYUContentLayoutBtn: UIButton {
   private(set) fileprivate var imgSize:CGSize = CGSize.zero;
   private(set) fileprivate var style:LYUButtonLayoutStyle = .none;
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
        let size = self.bounds.size;
        switch self.style {
        case .none:
            
            break;
        case .ImageLeftContentStart:
            self.imageView?.frame = CGRect(x: 0, y: (size.height - self.imgSize.height)/2.0, width: self.imgSize.width, height: self.imgSize.height)
            let labRect = self.titleLabel!.textRect(forBounds: CGRect(x: self.imgSize.width + self.space, y: 0, width: size.width - self.imgSize.width - self.space, height: size.height), limitedToNumberOfLines: self.titleLabel!.numberOfLines)
            self.titleLabel?.frame = CGRect(x: self.imgSize.width+self.space, y: (size.height - labRect.size.height)/2.0, width: size.width - self.imgSize.width - self.space, height: labRect.size.height)
            
            break;
        case .ImageLeftContentCenter:
            self.imageView?.frame = CGRect(x: 0, y: size.width/2.0 - self.imgSize.width - self.space/2.0, width: self.imgSize.width, height: self.imgSize.height);
            
            let labRect = self.titleLabel!.textRect(forBounds: CGRect(x: self.imgSize.width + self.space, y: 0, width: size.width - self.imgSize.width - self.space/2.0, height: size.height), limitedToNumberOfLines: self.titleLabel!.numberOfLines)
            
            self.titleLabel?.frame = CGRect(x: size.width/2.0 + self.space/2.0, y: (size.height - labRect.size.height)/2.0, width: size.width - self.imgSize.width - self.space/2.0, height: labRect.size.height)
            
            break;
        case .ImageRightContentStart:
            self.imageView?.frame = CGRect(x: size.width - self.imgSize.width, y: (size.height - self.imgSize.height)/2.0, width: self.imgSize.width, height: self.imgSize.height)
            
             let labRect = self.titleLabel!.textRect(forBounds: CGRect(x: 0, y: 0, width: size.width - self.imgSize.width - self.space, height: size.height), limitedToNumberOfLines: self.titleLabel!.numberOfLines)
            
            self.titleLabel?.frame = CGRect(x: 0, y: (size.height - labRect.size.height)/2.0, width: size.width - self.imgSize.width - self.space, height: labRect.size.height);
            
            break;
        case .ImageRightContentCenter:
              self.imageView?.frame = CGRect(x: size.width/2.0+self.space/2.0, y: (size.height - self.imgSize.height)/2.0, width: self.imgSize.width, height: self.imgSize.height)
              
             let labRect = self.titleLabel!.textRect(forBounds: CGRect(x: 0, y: 0, width: size.width - self.imgSize.width - self.space, height: size.height), limitedToNumberOfLines: self.titleLabel!.numberOfLines)
              
              self.titleLabel?.frame = CGRect(x: 0, y: (size.height - labRect.size.height)/2.0, width: size.width - self.imgSize.width - self.space, height: labRect.size.height);
              
            break;
            
        case .ImageTopContentCenter:
             self.imageView?.frame = CGRect(x: size.width/2.0 - self.imgSize.width/2.0, y: size.height/2.0 - self.space/2.0 - self.imgSize.height, width: self.imgSize.width, height: self.imgSize.height)
               let labRect = self.titleLabel!.textRect(forBounds: CGRect(x: 0, y: size.height/2.0+self.space/2.0, width: size.width , height: size.height/2.0 - self.space/2.0), limitedToNumberOfLines: self.titleLabel!.numberOfLines)
             self.titleLabel?.frame = CGRect(x: 0, y: size.height/2.0+self.space/2.0, width: size.width, height: labRect.size.height)
            break;
        case .ImageBottomContentCenter:
             self.imageView?.frame = CGRect(x: (size.width - self.imgSize.width)/2.0, y: size.height/2.0+self.space/2.0, width: self.imgSize.width, height: self.imgSize.height)
             
              let labRect = self.titleLabel!.textRect(forBounds: CGRect(x: 0, y:0, width: size.width , height: size.height/2.0 - self.space/2.0), limitedToNumberOfLines: self.titleLabel!.numberOfLines)
             
             self.titleLabel?.frame = CGRect(x: 0, y: size.height/2.0 - self.space/2.0 - labRect.size.height, width: size.width, height: labRect.size.height);
            break;
        }
 
    }
    
}
