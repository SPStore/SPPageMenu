//
//  ParentViewController.m
//  SPPageMenu
//
//  Created by leshengping on 16/9/6.
//  Copyright © 2016年 leshengping. All rights reserved.
//

#import "ParentViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "SevenViewController.h"
#import "EightViewController.h"
#import "NineViewController.h"
#import "TenViewController.h"

#import "SPPageMenu.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ParentViewController () <SPPageMenuDelegate, UIScrollViewDelegate> {
    
    CGFloat   _beginOffsetX;

}

@property (nonatomic, weak) SPPageMenu *pageMenu;

@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[[FirstViewController  alloc] init]];
    [self addChildViewController:[[SecondViewController alloc] init]];
    [self addChildViewController:[[ThirdViewController  alloc] init]];
    [self addChildViewController:[[FourViewController   alloc] init]];
    [self addChildViewController:[[FiveViewController   alloc] init]];
    [self addChildViewController:[[SixViewController    alloc] init]];
    [self addChildViewController:[[SevenViewController  alloc] init]];
    [self addChildViewController:[[EightViewController  alloc] init]];
    [self addChildViewController:[[NineViewController   alloc] init]];
    [self addChildViewController:[[TenViewController    alloc] init]];
    
//    @"女性",
//    @"电影",
//    @"电视剧",
//    @"搞笑"
    self.menuArray = @[@"军事计划",
                       @"生活",
                       @"手机",
                       @"娱乐天地",
                       @"电脑科技",
                       ];
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, kScreenWidth, 40)
                                                   array:self.menuArray];
    pageMenu.delegate = self;
    pageMenu.buttonFont = [UIFont systemFontOfSize:15];
    //pageMenu.selectedTitleColor = [UIColor greenColor];
    //pageMenu.unSelectedTitleColor = [UIColor orangeColor];
    //pageMenu.breaklineColor = [UIColor magentaColor];
    //pageMenu.showBreakline = NO;
    //pageMenu.showTracker = NO;
    pageMenu.trackerHeight = 5;
    //pageMenu.trackerColor = [UIColor blueColor];
    //pageMenu.firstButtonX = 50;
    //pageMenu.spacing = 30;
    pageMenu.openAnimation = NO;
    
    // 当allowBeyondScreen为YES, 则不管equalWidths是YES还是NO, 都将以scrollView的形式展示菜单按钮，可以滑动。此时equalWidths不起作用。这种情况适用于button的个数比较多。
    // 当allowBeyondScreen为NO
    // 1.如果equalWidths为YES,那么菜单按钮将会等宽，不可滑动，不会超出屏幕。这种情况适用于每个button的文字个数相等，button个数比较少，且不能超出屏幕。
    // 2.如果equalWidths为NO,那么菜单按钮的宽度将会根据其文字自适应，此时间距已经在内部计算好，外界设置间距不起作用。这种情况适用于每个buttond的文字个数不相等，button个数比较少，且不能超出屏幕
    pageMenu.allowBeyondScreen = YES;
    pageMenu.equalWidths = YES;
    
    // 实现block, 代理和block任选其一
//    pageMenu.buttonClicked_from_to_Block = ^(NSInteger fromIndex, NSInteger toIndex){
//        [self buttonClickedFrom:fromIndex to:toIndex];
//    };
    
    self.pageMenu = pageMenu;
    
    [self.view addSubview:pageMenu];
    
    [self.view addSubview:self.scrollView];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 104, kScreenWidth, kScreenHeight - 104);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.menuArray.count*_scrollView.frame.size.width, kScreenHeight - 104);
        [_scrollView addSubview:[self.childViewControllers firstObject].view];
        
    }
    return _scrollView;
}

// block方式监听菜单按钮被点击
/*
- (void)buttonClickedFrom:(NSInteger)fromIndex to:(NSInteger)toIndex {
    // 如果上一次点击的button下标与当前点击的buton下标之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:YES];
    }
    
    UIViewController *targetViewController = self.childViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    targetViewController.view.frame = CGRectMake(_scrollView.frame.size.width * toIndex, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:targetViewController.view];
}
 */

// pageMenu的代理方法
- (void)pageMenu:(SPPageMenu *)pageMenu buttonClickedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    // 如果上一次点击的button下标与当前点击的buton下标之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:YES];
    }
    
    UIViewController *targetViewController = self.childViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    targetViewController.view.frame = CGRectMake(_scrollView.frame.size.width * toIndex, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:targetViewController.view];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _beginOffsetX = scrollView.contentOffset.x;

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.pageMenu moveTrackerFollowScrollView:scrollView beginOffset:_beginOffsetX];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 手动滑scrollView,pageMenu会根据传进去的index选中index对应的button
    [self.pageMenu selectButtonAtIndex:index];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end












