//
//  LYUCardViewLayout.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/8/15.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

class LYUCardViewLayout: UICollectionViewFlowLayout {
    //所有cell的布局属性
    var layoutAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]();
    var leftItemSpaceing:CGFloat = 0.0;
    
    
    /// 初始化信息
    override init() {
        super.init();
        self.scrollDirection = .horizontal;
        
    }
    
    
    override func prepare() {
        super.prepare();
        let itemNum: Int = self.collectionView!.numberOfItems(inSection: 0);
        for j in 0..<itemNum{
            let layout = self.layoutAttributesForItem(at: IndexPath(item: j, section: 0))!;
            self.layoutAttributes.append(layout);
        }
        
    }
    
    
    
    /**
     返回true只要显示的边界发生改变就重新布局:(默认是false)
     内部会重新调用prepareLayout和调用
     layoutAttributesForElementsInRect方法获得部分cell的布局属性
     */
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
    
  
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
