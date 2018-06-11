//
//  LYUPagerViewCell.m
//  LYUPagerView
//
//  Created by 吕陈强 on 2018/4/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

#import "LYUPagerViewCell.h"

@implementation LYUPagerViewCell



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

- (void)setupUI{
    [self.contentView addSubview:self.indexLab];
}

- (void)layoutSubviews
{
    self.indexLab.frame = self.contentView.bounds;
}

- (UILabel *)indexLab
{
    if(_indexLab == nil){
        _indexLab = [[UILabel alloc] init];
        _indexLab.textColor = [UIColor blackColor];
        _indexLab.textAlignment = NSTextAlignmentCenter;
        _indexLab.font = [UIFont systemFontOfSize:20];
    }
    return _indexLab;
}
@end
