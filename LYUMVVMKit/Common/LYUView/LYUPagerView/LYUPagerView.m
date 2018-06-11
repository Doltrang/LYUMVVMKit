//
//  LYUPagerView.m
//  LYUPagerView
//
//  Created by 吕陈强 on 2018/4/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

#import "LYUPagerView.h"
#import "LYUPageCollectionView.h"
#import "LYUPagerTransformLayout.h"

#define kPagerViewMaxSectionCount 20
#define kPagerViewMinSectionCount 2


typedef struct {
    NSInteger index;
    NSInteger section;
} LYUIndexSection;


NS_INLINE BOOL TYEqualIndexSection(LYUIndexSection indexSection1,LYUIndexSection indexSection2) {
    return indexSection1.index == indexSection2.index && indexSection1.section == indexSection2.section;
}

NS_INLINE LYUIndexSection LYUMakeIndexSection(NSInteger index, NSInteger section) {
    LYUIndexSection indexSection;
    indexSection.index = index;
    indexSection.section = section;
    return indexSection;
}

@interface LYUPagerView()<UICollectionViewDataSource,UICollectionViewDelegate,TYCyclePagerTransformLayoutDelegate>
{
struct {
    unsigned int pagerViewDidScroll   :1;
    unsigned int didScrollFromIndexToNewIndex   :1;
    unsigned int initializeTransformAttributes   :1;
    unsigned int applyTransformToAttributes   :1;
} _delegateFlags;

struct {
    unsigned int cellForItemAtIndex   :1;
    unsigned int layoutForPagerView   :1;
} _dataSourceFlags;
}

/// UI
@property (nonatomic, strong) LYUPageCollectionView *collectionView;
@property (nonatomic, strong) LYUPagerViewLayout * layout;
@property (nonatomic, strong) NSTimer * timer;



// Data
@property (nonatomic, assign) NSInteger numberOfItems;
@property (nonatomic, assign) NSInteger curIndex;


@property (nonatomic, assign) LYUIndexSection indexSection; // current indexsection
@property (nonatomic, assign) NSInteger dequeueSection;
@property (nonatomic, assign) LYUIndexSection beginDragIndexSection;
@property (nonatomic, assign) NSInteger firstScrollIndex;


// layout
@property (nonatomic, assign) BOOL needClearLayout;
@property (nonatomic, assign) BOOL didReloadData;
@property (nonatomic, assign) BOOL didLayout;



// scrollView property
@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) BOOL tracking;
@property (nonatomic, assign) BOOL dragging;
@property (nonatomic, assign) BOOL decelerating;




@end


@implementation LYUPagerView

#pragma mark 初始化相关方法

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
    
    LYUPagerTransformLayout * collectionViewLayout =  [[LYUPagerTransformLayout alloc] init];
    LYUPageCollectionView * collectionView = [[LYUPageCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
    collectionViewLayout.delegate = _delegateFlags.applyTransformToAttributes ? self : nil;
//    collectionViewLayout.layout = self.layout;
    collectionView.frame = self.bounds;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:collectionView];

    self.collectionView = collectionView;
    


}

- (void)initData{
    self.didReloadData = false;
    self.didLayout = false;
    self.autoScrollInterval = 0;
    self.isInfiniteLoop = true;
    _beginDragIndexSection.index = 0;
    _beginDragIndexSection.section = 0;
    _indexSection.index = -1;
    _indexSection.section = -1;
    self.firstScrollIndex = -1;
    
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if(newWindow && _autoScrollInterval > 0){
        [self startTimer];
    }else{
        [self cancelTimer];
    }
}

#pragma mark 计时器的相关操作

# pragma 计时器相关
- (void)cancelTimer{
    if(self.timer == nil){
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
}
- (void)startTimer{
    if(self.timer || self.autoScrollInterval <= 0){
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollInterval target:self selector:@selector(flipNext) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)flipNext{
   
    if (!self.superview || !self.window || _numberOfItems == 0 || self.tracking) {
        return;
    }
    [self scrollToNearlyIndexAtDirection:LYUPagerScrollDirectionRight animate:true];
}

#pragma mark - getter


- (LYUPagerViewLayout *)layout {
    if (!_layout) {
        if (_dataSourceFlags.layoutForPagerView) {
            _layout = [_dataSource layoutForPagerView:self];
            _layout.isInfiniteLoop = _isInfiniteLoop;
        }
        if (_layout.itemSize.width <= 0 || _layout.itemSize.height <= 0) {
            _layout = nil;
        }
    }
    return _layout;
}

- (NSInteger)curIndex {
    return _indexSection.index;
}

- (CGPoint)contentOffset {
    return _collectionView.contentOffset;
}

- (BOOL)tracking {
    return _collectionView.tracking;
}

- (BOOL)dragging {
    return _collectionView.dragging;
}

- (BOOL)decelerating {
    return _collectionView.decelerating;
}

- (UIView *)backgroundView {
    return _collectionView.backgroundView;
}

- (__kindof UICollectionViewCell *)curIndexCell {
    return [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_indexSection.index inSection:_indexSection.section]];
}

- (NSArray<__kindof UICollectionViewCell *> *)visibleCells {
    return _collectionView.visibleCells;
}

- (NSArray *)visibleIndexs {
    NSMutableArray *indexs = [NSMutableArray array];
    for (NSIndexPath *indexPath in _collectionView.indexPathsForVisibleItems) {
        [indexs addObject:@(indexPath.item)];
    }
    return [indexs copy];
}


- (void)setBackgroundView:(UIView *)backgroundView {
    [_collectionView setBackgroundView:backgroundView];
}

- (void)setAutoScrollInterval:(CGFloat)autoScrollInterval {
    _autoScrollInterval = autoScrollInterval;
    [self cancelTimer];
    if (_autoScrollInterval > 0 && self.superview) {
        [self startTimer];
    }
}

- (void)setDelegate:(id<LYUPagerViewDelegate>)delegate {
    _delegate = delegate;
    _delegateFlags.pagerViewDidScroll = [delegate respondsToSelector:@selector(pagerViewDidScroll:)];
    _delegateFlags.didScrollFromIndexToNewIndex = [delegate respondsToSelector:@selector(pagerView:didScrollFromIndex:toIndex:)];
    _delegateFlags.initializeTransformAttributes = [delegate respondsToSelector:@selector(pagerView:initializeTransformAttributes:)];
    _delegateFlags.applyTransformToAttributes = [delegate respondsToSelector:@selector(pagerView:applyTransformToAttributes:)];
    if (self.collectionView && self.collectionView.collectionViewLayout) {
        ((LYUPagerTransformLayout *)self.collectionView.collectionViewLayout).delegate = _delegateFlags.applyTransformToAttributes ? self : nil;
    }
}

- (void)setDataSource:(id<LYUPagerViewDataSource>)dataSource {
    _dataSource = dataSource;
    _dataSourceFlags.cellForItemAtIndex = [dataSource respondsToSelector:@selector(pagerView:cellForItemAtIndex:)];
    _dataSourceFlags.layoutForPagerView = [dataSource respondsToSelector:@selector(layoutForPagerView:)];
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegate 代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _isInfiniteLoop ? kPagerViewMaxSectionCount : 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.numberOfItems = [_dataSource numberOfItems:self];
    return self.numberOfItems;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    _dequeueSection = indexPath.section;
    if (_dataSourceFlags.cellForItemAtIndex) {
        return [_dataSource pagerView:self cellForItemAtIndex:indexPath.row];
    }
    NSAssert(NO, @"pagerView cellForItemAtIndex: is nil!");
    return nil;
}



- (void)reloadData {
    _didReloadData = YES;
    [self setNeedClearLayout];
    [self clearLayout];
    [self updateData];
}

// not clear layout
- (void)updateData {
    [self updateLayout];
    _numberOfItems = [_dataSource numberOfItems:self];
    [_collectionView reloadData];
    if (!_didLayout && !CGRectIsEmpty(self.frame) && _indexSection.index < 0) {
        _didLayout = YES;
    }
    [self resetPagerViewAtIndex:_indexSection.index < 0 && !CGRectIsEmpty(self.frame) ? 0 :_indexSection.index];
}

- (void)scrollToNearlyIndexAtDirection:(LYUPagerViewScrollDirection)direction animate:(BOOL)animate {
    LYUIndexSection indexSection = [self nearlyIndexPathAtDirection:direction];
    [self scrollToItemAtIndexSection:indexSection animate:animate];
}

- (void)scrollToItemAtIndex:(NSInteger)index animate:(BOOL)animate {
    if (!_didLayout && _didReloadData) {
        _firstScrollIndex = index;
    }else {
        _firstScrollIndex = -1;
    }
    if (!_isInfiniteLoop) {
        [self scrollToItemAtIndexSection:LYUMakeIndexSection(index, 0) animate:animate];
        return;
    }
    
    [self scrollToItemAtIndexSection:LYUMakeIndexSection(index, index >= self.curIndex ? _indexSection.section : _indexSection.section+1) animate:animate];
}

- (void)scrollToItemAtIndexSection:(LYUIndexSection)indexSection animate:(BOOL)animate {
    if (_numberOfItems <= 0 || ![self isValidIndexSection:indexSection]) {
        //NSLog(@"scrollToItemAtIndex: item indexSection is invalid!");
        return;
    }
    
    if (animate && [_delegate respondsToSelector:@selector(pagerViewWillBeginScrollingAnimation:)]) {
        [_delegate pagerViewWillBeginScrollingAnimation:self];
    }
    CGFloat offset = [self caculateOffsetXAtIndexSection:indexSection];
    [_collectionView setContentOffset:CGPointMake(offset, _collectionView.contentOffset.y) animated:animate];
}

- (void)registerClass:(Class)Class forCellWithReuseIdentifier:(NSString *)identifier {
    [_collectionView registerClass:Class forCellWithReuseIdentifier:identifier];
}

- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier {
    [_collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}

- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index
{
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForItem:index inSection:_dequeueSection]];
    return cell;
}
//- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index {
//    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForItem:index inSection:_dequeueSection]];
//    return cell;
//}




#pragma mark - configure layout

- (void)updateLayout {
    if (!self.layout) {
        return;
    }
    self.layout.isInfiniteLoop = _isInfiniteLoop;
    ((LYUPagerTransformLayout *)_collectionView.collectionViewLayout).layout = self.layout;
}

- (void)clearLayout {
    if (_needClearLayout) {
        _layout = nil;
        _needClearLayout = NO;
    }
}

- (void)setNeedClearLayout {
    _needClearLayout = YES;
}

- (void)setNeedUpdateLayout {
    if (!self.layout) {
        return;
    }
    [self clearLayout];
    [self updateLayout];
    [_collectionView.collectionViewLayout invalidateLayout];
    [self resetPagerViewAtIndex:_indexSection.index < 0 ? 0 :_indexSection.index];
}

#pragma mark - pager index

- (BOOL)isValidIndexSection:(LYUIndexSection)indexSection {
    return indexSection.index >= 0 && indexSection.index < _numberOfItems && indexSection.section >= 0 && indexSection.section < kPagerViewMaxSectionCount;
}

- (LYUIndexSection)nearlyIndexPathAtDirection:(LYUPagerViewScrollDirection)direction{
    return [self nearlyIndexPathForIndexSection:_indexSection direction:direction];
}

- (LYUIndexSection)nearlyIndexPathForIndexSection:(LYUIndexSection)indexSection direction:(LYUPagerViewScrollDirection)direction {
    if (indexSection.index < 0 || indexSection.index >= _numberOfItems) {
        return indexSection;
    }
    
    if (!_isInfiniteLoop) {
        if (direction == LYUPagerScrollDirectionRight && indexSection.index == _numberOfItems - 1) {
            return _autoScrollInterval > 0 ? LYUMakeIndexSection(0, 0) : indexSection;
        } else if (direction == LYUPagerScrollDirectionRight) {
            return LYUMakeIndexSection(indexSection.index+1, 0);
        }
        
        if (indexSection.index == 0) {
            return _autoScrollInterval > 0 ? LYUMakeIndexSection(_numberOfItems - 1, 0) : indexSection;
        }
        return LYUMakeIndexSection(indexSection.index-1, 0);
    }
    
    if (direction == LYUPagerScrollDirectionRight) {
        if (indexSection.index < _numberOfItems-1) {
            return LYUMakeIndexSection(indexSection.index+1, indexSection.section);
        }
        if (indexSection.section >= kPagerViewMaxSectionCount-1) {
            return LYUMakeIndexSection(indexSection.index, kPagerViewMaxSectionCount-1);
        }
        return LYUMakeIndexSection(0, indexSection.section+1);
    }
    
    if (indexSection.index > 0) {
        return LYUMakeIndexSection(indexSection.index-1, indexSection.section);
    }
    if (indexSection.section <= 0) {
        return LYUMakeIndexSection(indexSection.index, 0);
    }
    return LYUMakeIndexSection(_numberOfItems-1, indexSection.section-1);
}

- (LYUIndexSection)caculateIndexSectionWithOffsetX:(CGFloat)offsetX {
    if (_numberOfItems <= 0) {
        return LYUMakeIndexSection(0, 0);
    }
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    CGFloat leftEdge = _isInfiniteLoop ? _layout.sectionInset.left : _layout.onlyOneSectionInset.left;
    CGFloat width = CGRectGetWidth(_collectionView.frame);
    CGFloat middleOffset = offsetX + width/2;
    CGFloat itemWidth = layout.itemSize.width + layout.minimumInteritemSpacing;
    NSInteger curIndex = 0;
    NSInteger curSection = 0;
    if (middleOffset - leftEdge >= 0) {
        NSInteger itemIndex = (middleOffset - leftEdge+layout.minimumInteritemSpacing/2)/itemWidth;
        if (itemIndex < 0) {
            itemIndex = 0;
        }else if (itemIndex >= _numberOfItems*kPagerViewMaxSectionCount) {
            itemIndex = _numberOfItems*kPagerViewMaxSectionCount-1;
        }
        curIndex = itemIndex%_numberOfItems;
        curSection = itemIndex/_numberOfItems;
    }
    return LYUMakeIndexSection(curIndex, curSection);
}

- (CGFloat)caculateOffsetXAtIndexSection:(LYUIndexSection)indexSection{
    if (_numberOfItems == 0) {
        return 0;
    }
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    CGFloat leftEdge = _isInfiniteLoop ? _layout.sectionInset.left : _layout.onlyOneSectionInset.left;
    CGFloat width = CGRectGetWidth(_collectionView.frame);
    CGFloat itemWidth = layout.itemSize.width + layout.minimumInteritemSpacing;
    CGFloat offsetX = leftEdge + itemWidth*(indexSection.index + indexSection.section*_numberOfItems) - layout.minimumInteritemSpacing/2 - (width - itemWidth)/2;
    return MAX(offsetX, 0);
}

- (void)resetPagerViewAtIndex:(NSInteger)index {
    if (_didLayout && _firstScrollIndex >= 0) {
        index = _firstScrollIndex;
        _firstScrollIndex = -1;
    }
    if (index < 0) {
        return;
    }
    if (index >= _numberOfItems) {
        index = 0;
    }
    [self scrollToItemAtIndexSection:LYUMakeIndexSection(index, _isInfiniteLoop ? kPagerViewMaxSectionCount/3 : 0) animate:NO];
    if (!_isInfiniteLoop && _indexSection.index < 0) {
        [self scrollViewDidScroll:_collectionView];
    }
}

- (void)recyclePagerViewIfNeed {
    if (!_isInfiniteLoop) {
        return;
    }
    if (_indexSection.section > kPagerViewMaxSectionCount - kPagerViewMinSectionCount || _indexSection.section < kPagerViewMinSectionCount) {
        [self resetPagerViewAtIndex:_indexSection.index];
    }
}



#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (!_isInfiniteLoop) {
        return _layout.onlyOneSectionInset;
    }
    if (section == 0 ) {
        return _layout.firstSectionInset;
    }else if (section == kPagerViewMaxSectionCount -1) {
        return _layout.lastSectionInset;
    }
    return _layout.middleSectionInset;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([_delegate respondsToSelector:@selector(pagerView:didSelectedItemCell:atIndex:)]) {
        [_delegate pagerView:self didSelectedItemCell:cell atIndex:indexPath.item];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_didLayout) {
        return;
    }
    LYUIndexSection newIndexSection =  [self caculateIndexSectionWithOffsetX:scrollView.contentOffset.x];
    if (_numberOfItems <= 0 || ![self isValidIndexSection:newIndexSection]) {
        NSLog(@"inVlaidIndexSection:(%ld,%ld)!",(long)newIndexSection.index,(long)newIndexSection.section);
        return;
    }
    LYUIndexSection indexSection = _indexSection;
    _indexSection = newIndexSection;
    
    if (_delegateFlags.pagerViewDidScroll) {
        [_delegate pagerViewDidScroll:self];
    }
    
    if (_delegateFlags.didScrollFromIndexToNewIndex && !TYEqualIndexSection(_indexSection, indexSection)) {
        //NSLog(@"curIndex %ld",(long)_indexSection.index);
        [_delegate pagerView:self didScrollFromIndex:MAX(indexSection.index, 0) toIndex:_indexSection.index];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_autoScrollInterval > 0) {
        [self cancelTimer];
    }
    _beginDragIndexSection = [self caculateIndexSectionWithOffsetX:scrollView.contentOffset.x];
    if ([_delegate respondsToSelector:@selector(pagerViewWillBeginDragging:)]) {
        [_delegate pagerViewWillBeginDragging:self];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (fabs(velocity.x) < 0.35 || !TYEqualIndexSection(_beginDragIndexSection, _indexSection)) {
        targetContentOffset->x = [self caculateOffsetXAtIndexSection:_indexSection];
        return;
    }
    LYUPagerViewScrollDirection direction = LYUPagerScrollDirectionRight;
    if ((scrollView.contentOffset.x < 0 && targetContentOffset->x <= 0) || (targetContentOffset->x < scrollView.contentOffset.x && scrollView.contentOffset.x < scrollView.contentSize.width - scrollView.frame.size.width)) {
        direction = LYUPagerScrollDirectionLeft;
    }
    LYUIndexSection indexSection = [self nearlyIndexPathForIndexSection:_indexSection direction:direction];
    targetContentOffset->x = [self caculateOffsetXAtIndexSection:indexSection];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_autoScrollInterval > 0) {
        [self startTimer];
    }
    if ([_delegate respondsToSelector:@selector(pagerViewDidEndDragging:willDecelerate:)]) {
        [_delegate pagerViewDidEndDragging:self willDecelerate:decelerate];
        
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(pagerViewWillBeginDecelerating:)]) {
        [_delegate pagerViewWillBeginDecelerating:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self recyclePagerViewIfNeed];
    if ([_delegate respondsToSelector:@selector(pagerViewDidEndDecelerating:)]) {
        [_delegate pagerViewDidEndDecelerating:self];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self recyclePagerViewIfNeed];
    if ([_delegate respondsToSelector:@selector(pagerViewDidEndScrollAnimation:)]) {
        [_delegate pagerViewDidEndScrollAnimation:self];
    }
}

#pragma mark - TYCyclePagerTransformLayoutDelegate

- (void)pagerViewTransformLayout:(LYUPagerTransformLayout *)pagerViewTransformLayout initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes {
    if (_delegateFlags.initializeTransformAttributes) {
        [_delegate pagerView:self initializeTransformAttributes:attributes];
    }
}

- (void)pagerViewTransformLayout:(LYUPagerTransformLayout *)pagerViewTransformLayout applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes {
    if (_delegateFlags.applyTransformToAttributes) {
        [_delegate pagerView:self applyTransformToAttributes:attributes];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    BOOL needUpdateLayout = !CGRectEqualToRect(_collectionView.frame, self.bounds);
    _collectionView.frame = self.bounds;
    if ((_indexSection.section < 0 || needUpdateLayout) && (_numberOfItems > 0 || _didReloadData)) {
        _didLayout = YES;
        [self setNeedUpdateLayout];
    }
}

- (void)dealloc {
    ((LYUPagerTransformLayout *)_collectionView.collectionViewLayout).delegate = nil;
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

@end
