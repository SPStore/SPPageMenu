//
//  SPPageMenu.h
//  SPPageMenu
//
//  Created by leshengping on 16/9/6.
//  Copyright © 2016年 leshengping. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPPageMenu;

@protocol SPPageMenuDelegate <NSObject>
@optional
- (void)pageMenu:(SPPageMenu *)pageMenu buttonClickedAtIndex:(NSInteger)index;
- (void)pageMenu:(SPPageMenu *)pageMenu buttonClickedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
@end

@interface SPPageMenu : UIView

@property (nonatomic, weak) id<SPPageMenuDelegate> delegate;

/** 分割线颜色 */
@property (nonatomic, strong) UIColor *breaklineColor;
/** button的字体,默认为15号字体 */
@property (nonatomic, strong) UIFont *buttonFont;
/** 选中的button的字体颜色（跟踪器的颜色始终与选中的button的字体颜色是一致的）*/
@property (nonatomic, strong) UIColor *selectedColor;
/** 未选中的button字体颜色 */
@property (nonatomic, strong) UIColor *unSelectedColor;
/** 是否显示分割线,默认为YES */
@property (nonatomic, assign, getter=isShowBreakline) BOOL showBreakline;
/** 是否开启动画,默认为NO */
@property (nonatomic, assign, getter=isOpenAnimation) BOOL openAnimation;
/** 是否显示跟踪器，默认为YES */
@property (nonatomic, assign, getter=isShowTracker) BOOL showTracker;
/** 跟踪器(跟踪button的下划线) */
@property (nonatomic, weak) UIView *tracker;
/** 跟踪器的高度 */
@property (nonatomic, assign) CGFloat trackerHeight;
/** button之间的间距 */
@property (nonatomic, assign) CGFloat padding;

@property (nonatomic, weak, readonly) UIButton *selectedButton;  // 选中的button

/*
 *  调用这个方法创建菜单栏
 */
+ (SPPageMenu *)pageMenuWithFrame:(CGRect)frame array:(NSArray *)array;

/*
 *  外界只要告诉该类index,内部会处理哪个button被选中
 */
- (void)selectButtonAtIndex:(NSInteger)index;

/*
 *  1.这个方法的功能是实现跟踪器跟随scrollView的滚动而滚动;
 *  2.调用这个方法必须在scrollViewDidScrollView里面调;
 *  3.beginOffset:scrollView刚开始滑动的时候起始偏移量,在scrollViewWillBeginDragging:方法内部获取起始偏移量;
 *  4.scrollView:正在滑动的scrollView;
 *  5.因此针对这个功能外界必须实现scrollViewWillBeginDragging:和scrollViewDidScrollView两个代理方法
 */
- (void)makeTrackerFollowScrollViewMoveWithBeginOffset:(CGFloat)beginOffset scrollView:(UIScrollView *)scrollView;

@end













