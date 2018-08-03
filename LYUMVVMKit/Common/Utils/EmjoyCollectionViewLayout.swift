//
//  EmjoyCollectionViewLayout.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/8/2.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation

class EmjoyCollectionViewLayout: UICollectionViewFlowLayout {
    
    var numRow:Int = 0;//行数
    var numCol:Int = 0;//列数
    var contentInsets: UIEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, 0)
    //所有cell的布局属性
    var layoutAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]();
    
    override init() {
        super.init();
        self.itemSize = CGSize(width: 50, height: 50);
        self.scrollDirection = .horizontal
        self.numRow = 5;
        self.numCol = 2;
        self.contentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //        self.minimumInteritemSpacing = 10
        //        self.minimumLineSpacing = 10;
    }
    
    //计算布局
    override func prepare() {
        
        let numsection = self.collectionView!.numberOfSections;
        let itemNum: Int = self.collectionView!.numberOfItems(inSection: 0)
        layoutAttributes.removeAll();
        for i in 0..<numsection{
            for j in 0..<itemNum{
                let layout = self.layoutAttributesForItem(at: IndexPath(item: j, section: i))!;
                self.layoutAttributes.append(layout);
            }
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
    
    /*
     根据indexPath去对应的UICollectionViewLayoutAttributes  这个是取值的，要重写，在移动删除的时候系统会调用改方法重新去UICollectionViewLayoutAttributes然后布局
     */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let layoutAttribute = super.layoutAttributesForItem(at: indexPath);
        assert((self.collectionView!.w-self.contentInsets.left - self.contentInsets.right) >= (self.itemSize.width*CGFloat(self.numRow)), "布局宽度不能超过父试图宽度")
        assert((self.collectionView!.h-self.contentInsets.top - self.contentInsets.bottom) >= self.itemSize.height*CGFloat(self.numCol), "布局高度不能超过父视图高度")
        
        //计算水平距离
        let hor_spacing = (self.collectionView!.w - CGFloat(self.numRow) * self.itemSize.width - self.contentInsets.left - self.contentInsets.right) / CGFloat(self.numRow - 1);
        
        //计算垂直距离
        let ver_spacing = (self.collectionView!.h - CGFloat(self.numCol) * self.itemSize.height - self.contentInsets.top - self.contentInsets.bottom) / CGFloat(self.numCol - 1);
        
        //计算x的位置
        var frame_x = CGFloat(indexPath.section) * self.collectionView!.w + CGFloat(indexPath.row%self.numRow) * self.itemSize.width + self.contentInsets.left;
        frame_x += (hor_spacing*(CGFloat(indexPath.row%self.numRow)));
        
        
        
        //计算y的位置
        var frame_y = CGFloat((indexPath.row/self.numRow)) * self.itemSize.height + self.contentInsets.top;
        
        frame_y += (ver_spacing*CGFloat(indexPath.row/self.numRow));
        
        layoutAttribute?.frame = CGRect(x:frame_x, y:frame_y, width: self.itemSize.width, height: self.itemSize.height);
        
        return layoutAttribute;
        
    }
    
    
    override open var collectionViewContentSize: CGSize {
        
        return CGSize(width: (self.collectionView?.w)! * CGFloat(self.collectionView!.numberOfSections), height: self.collectionView!.h);
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        /*
         //取出rect范围内所有的UICollectionViewLayoutAttributes，然而 //我们并不关心这个范围内所有的cell的布局，我们做动画是做给人看的， //所以我们只需要取出屏幕上可见的那些cell的rect即可
         let array = super.layoutAttributesForElements(in: rect)
         
         //可见矩阵
         let visiableRect = CGRect(x: self.collectionView!.contentOffset.x, y: self.collectionView!.contentOffset.y, width: self.collectionView!.frame.width, height: self.collectionView!.frame.height)
         
         
         //接下来的计算是为了动画效果
         let maxCenterMargin = self.collectionView!.bounds.width * 0.5 + 100 * 0.5;
         //获得collectionVIew中央的X值(即显示在屏幕中央的X)
         let centerX = self.collectionView!.contentOffset.x + self.collectionView!.frame.size.width * 0.5;
         for attributes in array! {
         //如果不在屏幕上，直接跳过
         if !visiableRect.intersects(attributes.frame) {continue}
         
         let scale = 1 + (0.8 - abs(centerX - attributes.center.x) / maxCenterMargin)
         
         attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
         
         }
         
         LLog(array)
         
         return array;
         */
        return self.layoutAttributes
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
