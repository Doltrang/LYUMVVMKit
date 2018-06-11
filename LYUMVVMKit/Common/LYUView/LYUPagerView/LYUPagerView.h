//
//  LYUPagerView.h
//  LYUPagerView
//
//  Created by 吕陈强 on 2018/4/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

#import <UIKit/UIKit.h>



@class LYUPagerView;
@class LYUPagerViewLayout;
@class LYUPageCollectionView;
@class LYUPagerTransformLayout;

typedef NS_ENUM(NSInteger,LYUPagerViewScrollDirection)
{
    LYUPagerScrollDirectionLeft,
    LYUPagerScrollDirectionRight
};



@protocol  LYUPagerViewDataSource <NSObject>
/// return num of item
- (NSUInteger)numberOfItems:(LYUPagerView *)pagerView;
/// return UICollectionViewCell or subclass with index
- (__kindof UICollectionViewCell *)pagerView:(LYUPagerView *)pagerView cellForItemAtIndex:(NSInteger)index;
/// return pagerview layout and cache layout
- (LYUPagerViewLayout *)layoutForPagerView:(LYUPagerView *)pagerView;

@end



@protocol LYUPagerViewDelegate <NSObject>
@optional;

/**
 pagerView did scroll to new index page
 */
- (void)pagerView:(LYUPagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
/**
 pagerView did selected item cell
 */
- (void)pagerView:(LYUPagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index;




/// Asks the delegate if the item should be highlighted during tracking.
- (BOOL)pagerView:(LYUPagerView *)pagerView shouldHighlightItemAtIndex:(int)index;


/// Tells the delegate that the item at the specified index was highlighted.
- (BOOL)pagerView:(LYUPagerView *)pagerView didHighlightItemAtIndex:(int)index;

/// Asks the delegate if the specified item should be selected.
- (BOOL)pagerView:(LYUPagerView *)pagerView shouldSelectItemAtIndex:(int)index;

// custom layout
- (void)pagerView:(LYUPagerView *)pageView initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;

- (void)pagerView:(LYUPagerView *)pageView applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;

/// Tells the delegate that the specified cell is about to be displayed in the pager view.
- (void)pagerView:(LYUPagerView *)pagerView willDisplayCell:(__kindof UICollectionViewCell *)cell forItemAtIndex:(int)index;

/// Tells the delegate that the specified cell was removed from the pager view.
- (void)pagerView:(LYUPagerView *)pagerView didEndDisplayingCell:(__kindof UICollectionViewCell *)cell forItemAtIndex:(int)index;



/// Tells the delegate when the user scrolls the content view within the receiver.
- (void)pagerViewDidScroll:(LYUPagerView *)pagerView;

/// Tells the delegate when the pager view is about to start scrolling the content.
- (void)pagerViewWillBeginDragging:(LYUPagerView *)pagerView;

- (void)pagerViewWillBeginDecelerating:(LYUPagerView *)pageView;

- (void)pagerViewWillBeginScrollingAnimation:(LYUPagerView *)pageView;

/// Tells the delegate when the user finishes scrolling the content
- (void)pagerViewWillEndDragging:(LYUPagerView *)pagerView targetIndex:(int)index;

- (void)pagerViewDidEndDragging:(LYUPagerView *)pageView willDecelerate:(BOOL)decelerate;

/// Tells the delegate when a scrolling animation in the pager view concludes.
- (void)pagerViewDidEndScrollAnimation:(LYUPagerView *)pagerView;

/// Tells the delegate that the pager view has ended decelerating the scrolling movement.
- (void)pagerViewDidEndDecelerating:(LYUPagerView *)pagerView;



@end




@interface LYUPagerView : UIView

// will be automatically resized to track the size of the pagerView
@property (nonatomic, strong, nullable) UIView *backgroundView;

@property (nonatomic, weak) id <LYUPagerViewDataSource> dataSource;
@property (nonatomic, weak) id <LYUPagerViewDelegate> delegate;

@property (nonatomic, strong, readonly) LYUPageCollectionView *collectionView;
@property (nonatomic, strong, readonly) LYUPagerViewLayout * layout;


/**
 Infinite pageview . defalut true
 */
@property (nonatomic, assign) BOOL isInfiniteLoop;


/**
  pagerView automatic scroll time interval, default 0,disable automatic
 */
@property (nonatomic, assign) CGFloat autoScrollInterval;



/**
 current page index
 */
@property (nonatomic, assign, readonly) NSInteger curIndex;

// scrollView property
@property (nonatomic, assign, readonly) CGPoint contentOffset;
@property (nonatomic, assign, readonly) BOOL tracking;
@property (nonatomic, assign, readonly) BOOL dragging;
@property (nonatomic, assign, readonly) BOOL decelerating;



/**
 reload data, !!important!!: will clear layout and call delegate layoutForPagerView
 */
- (void)reloadData;

/**
 update data is reload data, but not clear layuot
 */
- (void)updateData;


/**
 if you only want update layout
 */
- (void)setNeedUpdateLayout;

/**
 will set layout nil and call delegate->layoutForPagerView
 */
- (void)setNeedClearLayout;


/**
  register pager view cell with class
 */
- (void)registerClass:(nullable Class)cls forCellWithReuseIdentifier:(NSString *)identifier;
/**
 register pager view cell with nib
 */
- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;
/**
 dequeue reusable cell for pagerView
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index ;
/**
 current index cell in pagerView
 */
- (__kindof UICollectionViewCell * _Nullable)curIndexCell;


/**
 visible cells in pageView
 */
- (NSArray<__kindof UICollectionViewCell *> *_Nullable)visibleCells;


/**
 scroll to item at index
 */
- (void)scrollToItemAtIndex:(NSInteger)index animate:(BOOL)animate;

/**
 scroll to next or pre item
 */
- (void)scrollToNearlyIndexAtDirection:(LYUPagerViewScrollDirection)direction animate:(BOOL)animate;



@end
