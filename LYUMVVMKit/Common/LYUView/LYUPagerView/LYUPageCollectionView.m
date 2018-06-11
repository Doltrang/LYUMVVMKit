//
//  LYUPagerViewCollectionView.m
//  Ipad_hd
//
//  Created by 吕陈强 on 2018/4/20.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

#import "LYUPageCollectionView.h"
#import "LYUPagerView.h"
#import "LYUPagerViewCell.h"
@interface LYUPageCollectionView()

@property (nonatomic, strong) LYUPagerView * pageView;

@end


@implementation LYUPageCollectionView

- (instancetype)init
{
    if(self = [super init]){
        [self setupUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if(self = [super initWithFrame:frame collectionViewLayout:layout]){
        [self setupUI];
    }
    return self;
}


- (void)setContentInset:(UIEdgeInsets)contentInset
{
    [super setContentInset:contentInset];
    if(self.contentInset.top > 0){
        CGPoint contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y + contentInset.top);
        self.contentOffset = contentOffset;
    }
    
    
}

- (LYUPagerView *)pageView
{
    if(_pageView == nil){
        _pageView = (LYUPagerView *)(self.superview.superview);
    }
    return _pageView;
}
- (void)setupUI{
    self.contentInset = UIEdgeInsetsZero;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.showsVerticalScrollIndicator = false;
    self.showsHorizontalScrollIndicator = false;
    self.pagingEnabled = false;
    self.decelerationRate = 1-0.0076;
    [self registerClass:[LYUPagerViewCell class] forCellWithReuseIdentifier:@"LYUPagerViewCell"];
    if (@available(iOS 10.0, *)) {
        self.prefetchingEnabled = false;
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
//    self.pagingEnabled = true;
    
}

@end
