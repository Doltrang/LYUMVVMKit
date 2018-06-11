//
//  LYUPageControl.m
//  LYUPagerView
//
//  Created by 吕陈强 on 2018/4/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

#import "LYUPageControl.h"

@interface LYUPageControl()

/// [UIControlState: UIBezierPath]
@property (nonatomic, copy) NSMutableDictionary * paths;

/// [UIControlState: CGFloat]
@property (nonatomic, copy) NSMutableDictionary * alphas;

/// [UIControlState: UIImage]
@property (nonatomic, copy) NSMutableDictionary * images;

/// [UIControlState: UIColor]
@property (nonatomic, copy) NSMutableDictionary * fillColors;

/// [UIControlState: UIColor]
@property (nonatomic, copy) NSMutableDictionary * strokeColors;

///  [UIControlState: CGAffineTransform]
@property (nonatomic, copy) NSMutableDictionary  * transforms;

// [CAShapeLayer]
@property (nonatomic, copy) NSArray * indicatorLayers;

@property (nonatomic, assign) BOOL needsUpdateIndicators;

@property (nonatomic, assign) BOOL needsCreateIndicators;


@end





@implementation LYUPageControl

#pragma mark 初始化
- (instancetype)init
{
    if(self = [super init]){
        [self initData];
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self initData];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    [self addSubview:self.contentView];
}

- (void)initData{
    self.numOfAllPages = 0;
    self.currentPageOfAll = 0;
    self.itemSpacing = 6.0;
    self.interitemSpacing = 6.0;
    self.hidden = false;
    self.hidesForSinglePage = false;
    self.userInteractionEnabled = false;
    self.contentInsets = UIEdgeInsetsZero;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
}


#pragma mark 控件初始化

- (UIView *)contentView
{
    if(_contentView == nil){
        _contentView = [UIView new];
        _contentView.backgroundColor = self.backgroundColor;
    }
    return _contentView;
}

- (NSMutableDictionary *)paths
{
    if(_paths == nil){
        _paths = [NSMutableDictionary new];
    }
    return _paths;
}

- (NSMutableDictionary *)alphas
{
    if(_alphas == nil){
        _alphas = [NSMutableDictionary new];
    }
    return _alphas;
}

- (NSMutableDictionary *)images
{
    if(_images == nil){
        _images = [NSMutableDictionary new];
    }
    return _images;
}

- (NSMutableDictionary *)fillColors
{
    if(_fillColors == nil){
        _fillColors = [NSMutableDictionary new];
    }
    return _fillColors;
}

- (NSMutableDictionary *)strokeColors
{
    if(_strokeColors == nil){
        _strokeColors = [NSMutableDictionary new];
    }
    return _strokeColors;
}

- (NSMutableDictionary *)transforms
{
    if(_transforms == nil){
        _transforms = [NSMutableDictionary new];
    }
    return _transforms;
}


- (void)setNumOfAllPages:(NSInteger)numOfAllPages
{
    _numOfAllPages = numOfAllPages;
     [self setNeedsCreateIndicators];
}

- (void)setCurrentPageOfAll:(NSInteger)currentPageOfAll
{
    _currentPageOfAll = currentPageOfAll;
    [self setNeedsUpdateIndicators];
}


- (void)setItemSpacing:(CGFloat)itemSpacing
{
    _itemSpacing = itemSpacing;
    [self setNeedsUpdateIndicators];
}

- (void)setInteritemSpacing:(CGFloat)interitemSpacing
{
    _interitemSpacing = interitemSpacing;
    [self setNeedsUpdateIndicators];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    [self setNeedsLayout];
}


- (void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    [super setContentHorizontalAlignment:contentHorizontalAlignment];
    [self setNeedsLayout];
}



- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage
{
    [super setHidesForSinglePage:hidesForSinglePage];
    [self setNeedsUpdateIndicators];
}

# pragma mark 刷新UI操作

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof(self) weakself = self;
    self.contentView.frame = ^{
        __strong typeof(weakself) strongself = weakself;
        return CGRectMake(strongself.contentInsets.left, strongself.contentInsets.top, (strongself.frame.size.width - strongself.contentInsets.left - strongself.contentInsets.right), (strongself.frame.size.height - self.contentInsets.top - self.contentInsets.bottom));
    }();
}


- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    
    CGFloat diameter = self.itemSpacing;
    CGFloat spacing = self.interitemSpacing;
    __weak typeof(self) weakself = self;
    __block CGFloat x = ^{
        __strong typeof(weakself) strongself = weakself;
        switch (strongself.contentHorizontalAlignment) {
            case UIControlContentHorizontalAlignmentLeft:
            case UIControlContentHorizontalAlignmentLeading:
                return 0.0;
            case UIControlContentHorizontalAlignmentCenter:
            case UIControlContentHorizontalAlignmentFill:
            {
                CGFloat midX = CGRectGetMidX(strongself.contentView.bounds);
                CGFloat amplitude = (strongself.numOfAllPages/2.0) * diameter + spacing * (strongself.numOfAllPages - 1)/2.0;
                return (midX - amplitude);
            }
                
            case UIControlContentHorizontalAlignmentTrailing:
            case UIControlContentHorizontalAlignmentRight:
            {
                CGFloat contentWidth = diameter * strongself.numOfAllPages + (strongself.numOfAllPages - 1) * spacing;
                return (strongself.contentView.frame.size.width - contentWidth);
            }
            default:
                break;
        }
        return 0.0;
    }();
    
    [self.indicatorLayers enumerateObjectsUsingBlock:^(CALayer * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIControlState state = idx == self.currentPageOfAll ? UIControlStateSelected:UIControlStateNormal;
        
        UIImage * image = self.images[@(state)];
        CGSize size = (image != nil) ? image.size : CGSizeMake(diameter, diameter);
        CGPoint origin = CGPointMake(x - (size.width-diameter)*0.5, CGRectGetMidY(self.contentView.bounds) -size.height*0.5);
        
        obj.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
        x = x + spacing + diameter;
    }];
    
}





- (void)setNeedsUpdateIndicators{
    self.needsUpdateIndicators = true;
    [self setNeedsLayout];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateIndicatorsIfNecessary];
    });
}

- (void)updateIndicatorsIfNecessary{
    if(self.needsUpdateIndicators == false){
        return;
    }
    if(!self.indicatorLayers || self.indicatorLayers.count <= 0 ){
        return ;
    }
    
    self.needsUpdateIndicators = false;
    if(self.numOfAllPages){
        self.contentView.hidden = (self.hidesForSinglePage && self.numOfAllPages <= 1);
        if(self.contentView.hidden == false){
            [self.indicatorLayers enumerateObjectsUsingBlock:^(CAShapeLayer * layer, NSUInteger idx, BOOL * _Nonnull stop) {
                layer.hidden = false;
                [self updateIndicatorAttributes:layer];
            }];
        }
    }
  
    
}

- (void)updateIndicatorAttributes:(CAShapeLayer *)layer{
    NSInteger index = [self.indicatorLayers indexOfObject:layer];
    UIControlState state = index == self.currentPageOfAll ? UIControlStateSelected:UIControlStateNormal;
    
    /// 优先设置图片
    if(self.images && [self.images.allKeys containsObject:@(state)]){
        layer.strokeColor = nil;
        layer.fillColor = nil;
        layer.path = nil;
        UIImage * image = self.images[@(state)];
        layer.contents = (__bridge id _Nullable)(image.CGImage);
       
        
    }else { /// 不存在图片的情况
        layer.contents = nil;
        UIColor * strokeColor = self.strokeColors[@(state)];
        UIColor * fillColor = self.fillColors[@(state)];
        if(strokeColor == nil && fillColor == nil){
            layer.fillColor = ((state == UIControlStateSelected)? [UIColor whiteColor] : [UIColor grayColor]).CGColor ;
            layer.strokeColor = nil;
            
        }else{
            layer.fillColor = fillColor.CGColor;
            layer.strokeColor = strokeColor.CGColor;
        }
        if(self.paths[@(state)]){
            UIBezierPath * path = self.paths[@(state)];
            layer.path = path.CGPath;
        }else{
            layer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.itemSpacing, self.itemSpacing)].CGPath ;
        }
        
    }
    
    if(self.transforms[@(state)]){
        
        //        [NSValue valueWithCGAffineTransform:<#(CGAffineTransform)#>]
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformFromString([NSString stringWithFormat:@"%@",self.transforms[@(state)]]));
    }
    
    if(self.alphas[@(state)]){
        layer.opacity = [self.alphas[@(state)] floatValue];
    }
    
}

- (void)setNeedsCreateIndicators{
    self.needsCreateIndicators = true;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self createIndicatorsIfNecessary];
    });
}


- (void)createIndicatorsIfNecessary{
    if(!self.needsCreateIndicators){
        return ;
    }
    
    self.needsCreateIndicators = false;
    [CATransaction begin];
    [CATransaction setDisableActions:true];
    
    if(self.currentPageOfAll >= self.numOfAllPages){
        self.currentPageOfAll = self.numOfAllPages - 1;
    }
    
    [self.indicatorLayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    NSLog(@"%ld---",(long)self.numOfAllPages);
    self.indicatorLayers = nil;
    NSMutableArray * layerArr = [NSMutableArray array];
    for(int index = 0; index <= self.numOfAllPages; index ++){
        CAShapeLayer * layer =  [[CAShapeLayer alloc] init];
        layer.actions = @{@"bounds":[NSNull null]};
        [self.contentView.layer addSublayer:layer];
        [layerArr addObject:layer];
    }
    self.indicatorLayers = [layerArr copy];
    [self setNeedsUpdateIndicators];
    [self updateIndicatorsIfNecessary];
    [CATransaction commit];
    
}


#pragma mark 外部设置方法

- (void)setPath:(UIBezierPath *)path state:(UIControlState)state{
    self.paths[@(state)] = path;
    [self setNeedsUpdateIndicators];
}

- (void)setAlpha:(CGFloat)alpha state:(UIControlState)state{
    self.alphas[@(state)] = @(alpha);
    [self setNeedsUpdateIndicators];
}

- (void)setImage:(UIImage *)image state:(UIControlState)state{
    self.images[@(state)] = image;
    [self setNeedsUpdateIndicators];
}

- (void)setFillColor:(UIColor *)color state:(UIControlState)state{
    self.fillColors[@(state)] = color;
    [self setNeedsUpdateIndicators];
}

- (void)setStrokeColor:(UIColor *)color state:(UIControlState)state{
    self.strokeColors[@(state)] = color;
    [self setNeedsUpdateIndicators];
}

- (void)setTransform:(CGAffineTransform)transform state:(UIControlState)state{
    self.transforms[@(state)] = [NSValue valueWithCGAffineTransform:transform];
    [self setNeedsUpdateIndicators];
}



@end
