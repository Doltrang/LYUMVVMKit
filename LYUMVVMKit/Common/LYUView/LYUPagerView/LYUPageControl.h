//
//  LYUPageControl.h
//  LYUPagerView
//
//  Created by 吕陈强 on 2018/4/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYUPageControl : UIPageControl


/// The Spacing to use of page indicators in the pagecontrol
@property (nonatomic, assign) CGFloat itemSpacing;

@property (nonatomic, assign) CGFloat interitemSpacing;

@property (nonatomic, assign) UIEdgeInsets contentInsets;

@property (nonatomic, assign) NSInteger numOfAllPages;
@property (nonatomic, assign) NSInteger currentPageOfAll;


@property (nonatomic, copy) UIView * contentView;


- (void)setPath:(UIBezierPath *)path state:(UIControlState)state;
- (void)setAlpha:(CGFloat)alpha state:(UIControlState)state;
- (void)setImage:(UIImage *)image state:(UIControlState)state;
- (void)setFillColor:(UIColor *)color state:(UIControlState)state;
- (void)setStrokeColor:(UIColor *)color state:(UIControlState)state;
- (void)setTransform:(CGAffineTransform)transform state:(UIControlState)state;

@end
