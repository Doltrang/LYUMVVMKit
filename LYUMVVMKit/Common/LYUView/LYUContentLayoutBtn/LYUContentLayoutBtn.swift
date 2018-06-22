//
//  LYUContentLayoutBtn.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/24.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

enum LYUButtonLayoutStyle {
    case ImageLeft        /// 图片居左 文字配合间距 整体垂直方向居中
    case ImageRight      /// 图片居右 文字配合间距 整体垂直方向居中
    case ImageTop         /// 图片居上  文字配合间距 整体水平方向居中
    case ImageBottom   /// 图片居下 文字配合间距 整体水平方向居中
}

class LYUContentLayoutBtn: UIButton {
   private(set) fileprivate var imgSize:CGSize = CGSize.zero;
   private(set) fileprivate var style:LYUButtonLayoutStyle = .ImageTop;
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
        case .ImageTop:
            self.imageView?.frame = CGRect(x: (size.width - self.imgSize.width)/2.0, y: 0, width: self.imgSize.width, height: self.imgSize.height);
            self.titleLabel?.frame = CGRect(x: 0, y: self.imgSize.height + space, width: size.width, height: size.height - self.imgSize.height - self.space);
        case .ImageBottom:
             self.imageView?.frame = CGRect(x: (size.width - self.imgSize.width)/2.0, y: size.height - self.imgSize.height, width: self.imgSize.width, height: self.imgSize.height);
             self.titleLabel?.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - self.space - self.imgSize.height);
        case .ImageLeft:
            self.imageView?.frame = CGRect(x: 0, y: (size.height - self.imgSize.height)/2.0, width: self.imgSize.width, height: self.imgSize.height);
            self.titleLabel?.frame = CGRect(x: self.imgSize.width + self.space, y: 0, width: (size.width - self.imgSize.width - self.space), height: size.height);
        case .ImageRight:
            self.imageView?.frame = CGRect(x: size.width - self.imgSize.width, y: (size.height - self.imgSize.height)/2.0, width: self.imgSize.width, height: self.imgSize.height);
            self.titleLabel?.frame = CGRect(x: 0, y:0, width: size.width - self.space - self.imgSize.width, height: size.height);
        }
 
    }
    
}
