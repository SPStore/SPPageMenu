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
    
    CGFloat   _oldOffsetX;

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

    self.menuArray = @[@"军事计划",
                       @"生活",
                       @"手机",
                       @"每日新鲜",
                       @"美女",
                       @"娱乐",
                       @"婚姻",
                       @"中央",
                       @"汽车",
                       @"电影"];
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, kScreenWidth, 40)
                                                   array:self.menuArray];
    self.pageMenu = pageMenu;
    pageMenu.delegate = self;
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

    _oldOffsetX = scrollView.contentOffset.x;

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width-scrollView.bounds.size.width) {
        return;
    }
    [self.pageMenu makeTrackerFollowScrollViewMoveWithBeginOffset:_oldOffsetX scrollView:scrollView];
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












