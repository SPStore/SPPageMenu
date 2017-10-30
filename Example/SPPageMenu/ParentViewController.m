//
//  ViewController.m
//  SPPageMenu
//
//  Created by 乐升平 on 17/10/26.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ParentViewController.h"
#import "SPPageMenu.h"
#import "BaseViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThidViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "SevenViewController.h"
#import "EightViewController.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define pageMenuH 40
#define scrollViewHeight (screenH-64-pageMenuH)

@interface ParentViewController () <SPPageMenuDeleagte, UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) SPPageMenu *pageMenu;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;
@end

@implementation ParentViewController

// 示例1:SPPageMenuTrackerStyleLine,下划线样式
- (void)test1 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];

    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLine];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例2:SPPageMenuTrackerStyleLineLongerThanItem,下划线比item略长，长度等于tem宽＋间距
- (void)test2 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineLongerThanItem];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例3:SPPageMenuTrackerStyleLineAttachment,下划线依恋样式，当滑动底下装载控制器的scrollView时，该下划线会有阻尼效果
- (void)test3 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例4:SPPageMenuTrackerStyleTextColorGradients,文字颜色渐变
- (void)test4 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleTextColorGradients];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例5:SPPageMenuTrackerStyleTextColorGradientsAndZoom,文字颜色渐变且缩放
- (void)test5 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleTextColorGradientsAndZoom];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例6:SPPageMenuTrackerStyleRoundedRect,圆角矩形
- (void)test6 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleRoundedRect];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例7:SPPageMenuTrackerStyleRect,矩形

- (void)test7 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleRect];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例8:可滑动的自适应内容排列，pageMenu.permutationWay = SPPageMenuPermutationWayScrollAdaptContent;
- (void)test8 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLine];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 可滑动的自适应内容排列
    pageMenu.permutationWay = SPPageMenuPermutationWayScrollAdaptContent;
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例9:不可滑动的等宽排列，pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
- (void)test9 {
    self.dataArr = @[@"生活",@"影视中心",@"交通"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLine];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 不可滑动的等宽排列
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例10:不可滑动的自适应内容排列，pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
// 这种排列方式下,itemPadding属性无效，因为内部自动计算间距
- (void)test10 {
    self.dataArr = @[@"生活",@"影视中心",@"交通"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLine];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 不可滑动的自适应内容排列
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例11:显示功能按钮
- (void)test11 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    pageMenu.showFuntionButton = YES;
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例12:给功能按钮设置图片和文字
- (void)test12 {
    self.dataArr = @[@"生活",@"娱乐",@"交通"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineLongerThanItem];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 同时设置图片和文字，如果只想要文字，image传nil，如果只想要图片，title传nil，imagePosition和ratio传0即可
    [pageMenu setFunctionButtonTitle:@"更多" image:[UIImage imageNamed:@"Expression_1"] imagePosition:SPItemImagePositionTop imageRatio:0.5 forState:UIControlStateNormal];
    [pageMenu setFunctionButtonTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    pageMenu.showFuntionButton = YES;
    // 等宽,不可滑动
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例13:含有图片的item
- (void)test13 {
    self.dataArr = @[@"生活",[UIImage imageNamed:@"Expression_1"],@"交通",[UIImage imageNamed:@"Expression_2"],@"搞笑",@"综艺"];

    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineLongerThanItem];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    pageMenu.showFuntionButton = NO;
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例14:指定item携带图片,或同时携带图片和文字,可以设置图片的位置
- (void)test14 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleRect];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:2];
    // 指定第1个item为图片，第2个是指数组中的下标1
    [pageMenu setImage:[UIImage imageNamed:@"Expression_1"] forItemAtIndex:0];
    // 指定第2个item同时含有图片和文字，图片在上
    [pageMenu setTitle:@"哈哈" image:[UIImage imageNamed:@"Expression_2"] imagePosition:SPItemImagePositionTop imageRatio:0.5 forItemIndex:1];
    // 指定第4个item同时含有图片和文字，图片在右
    [pageMenu setTitle:@"哈哈" image:[UIImage imageNamed:@"Expression_3"] imagePosition:SPItemImagePositionRight imageRatio:0.3 forItemIndex:3];
    pageMenu.showFuntionButton = NO;
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例15: 关闭跟踪器的跟踪效果,关闭后，只有scrollView滑动结束时才会跟踪
- (void)test15 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineLongerThanItem];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    pageMenu.closeTrackerFollowingfMode = YES;
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例16:简单属性和简单方法
- (void)test16 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧"];
    
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineLongerThanItem];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:2];
    // 以下属性可以打开一一测试，所有属性和方法均不分先后顺序
    //pageMenu.itemTitleFont = [UIFont systemFontOfSize:20];
    //pageMenu.selectedItemTitleColor = [UIColor magentaColor];
    //pageMenu.unSelectedItemTitleColor = [UIColor greenColor];
    //pageMenu.tracker.hidden = YES;
    //pageMenu.dividingLine.hidden = YES;
    //pageMenu.dividingLine.backgroundColor = [UIColor redColor];
    //pageMenu.contentInset = UIEdgeInsetsMake(0, 50, 0, 50);
    //[pageMenu setWidth:20 forItemAtIndex:2];
    pageMenu.itemPadding = 80;
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

- (void)test17 {
    self.dataArr = nil;
    
    NSString *text = @"本框架的bridgeScrollView属性是一个很重要但又容易忽略的属性，在viewDidLoad中，每种示例都传了一个scrollView，即:“self.pageMenu.bridgeScrollView = self.scrollView”，这一传递，SPPageMenu内部会监听该scrollView的滑动状况，当该scrollView滑动的时候，就可以让跟踪器时刻跟随；如果你忘了设置这个属性，或者觉得不好，也可以在scrollViewDidScrollView中调用接口“- (void)moveTrackerFollowScrollView:(UIScrollView *)scrollView”,这样也能实现跟踪器时刻跟随scrollView；如果不想让跟踪器随时都跟踪，直到scrollView滑动结束才跟踪，在上面2种方式采取了任意一种的情况下，可以设置属性”pageMenu.closeTrackerFollowingfMode = YES“";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenW-20, screenH)];
    label.numberOfLines = 0;
    label.alpha = 0.6;
    label.font = [UIFont systemFontOfSize:15];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.firstLineHeadIndent = label.font.pointSize * 2; // 首行缩进2格
    [paragraphStyle setLineSpacing:6]; // 行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    label.attributedText = attributedString;
    [self.view addSubview:label];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (_testNumber) {
        case 0:
            [self test1];
            break;
        case 1:
            [self test2];
            break;
        case 2:
            [self test3];
            break;
        case 3:
            [self test4];
            break;
        case 4:
            [self test5];
            break;
        case 5:
            [self test6];
            break;
        case 6:
            [self test7];
            break;
        case 7:
            [self test8];
            break;
        case 8:
            [self test9];
            break;
        case 9:
            [self test10];
            break;
        case 10:
            [self test11];
            break;
        case 11:
            [self test12];
            break;
        case 12:
            [self test13];
            break;
        case 13:
            [self test14];
            break;
        case 14:
            [self test15];
            break;
        case 15:
            [self test16];
            break;
        case 16:
            [self test17];
            break;
        default:
            break;
    }
    
    NSArray *controllerClassNames = [NSArray arrayWithObjects:@"FirstViewController",@"SecondViewController",@"ThidViewController",@"FourViewController",@"FiveViewController",@"SixViewController",@"SevenViewController",@"EightViewController", nil];
    for (int i = 0; i < self.dataArr.count; i++) {
        if (controllerClassNames.count > i) {
            BaseViewController *baseVc = [[NSClassFromString(controllerClassNames[i]) alloc] init];
            NSString *text = [self.pageMenu titleForItemAtIndex:i];
            if (text) {
                baseVc.text = text;
            } else {
                baseVc.text = @"图片";
            }
            [self addChildViewController:baseVc];
            // 控制器本来自带childViewControllers,但是遗憾的是该数组的元素顺序永远无法改变，只要是addChildViewController,都是添加到最后一个，而控制器不像数组那样，可以插入或删除任意位置，所以这里自己定义可变数组，以便插入(删除)(如果没有插入(删除)功能，直接用自带的childViewControllers即可)
            [self.myChildViewControllers addObject:baseVc];
        }
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+pageMenuH, screenW, scrollViewHeight)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    // 这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
    self.pageMenu.bridgeScrollView = self.scrollView;
    
    // pageMenu.selectedItemIndex就是选中的item下标
    if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
        BaseViewController *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
        [scrollView addSubview:baseVc.view];
        baseVc.view.frame = CGRectMake(screenW*self.pageMenu.selectedItemIndex, 0, screenW, scrollViewHeight);
        scrollView.contentOffset = CGPointMake(screenW*self.pageMenu.selectedItemIndex, 0);
        scrollView.contentSize = CGSizeMake(self.dataArr.count*screenW, 0);
    }
}

#pragma mark - SPPageMenu的代理方法

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(screenW * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(screenW * toIndex, 0) animated:YES];
    }
    if (self.myChildViewControllers.count <= toIndex) {return;}
    
    UIViewController *targetViewController = self.myChildViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    targetViewController.view.frame = CGRectMake(screenW * toIndex, 0, screenW, scrollViewHeight);
    [_scrollView addSubview:targetViewController.view];
    
}

- (void)pageMenu:(SPPageMenu *)pageMenu functionButtonClicked:(UIButton *)functionItem {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"插入一个带标题的item" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self insertItemWithObject:@"十九大" toIndex:0];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"插入一个带图片的item" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self insertItemWithObject:[UIImage imageNamed:@"Expression_1"] toIndex:1];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"删除一个item" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self removeItemAtIndex:1];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"删除所有item" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self removeAllItems];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - insert or remove

// object是插入的对象(NSString或UIImage),insertNumber是插入到第几个
- (void)insertItemWithObject:(id)object toIndex:(NSInteger)insertNumber {
    // 插入之前，先将新控制器之后的控制器view往后偏移
    for (int i = 0; i < self.myChildViewControllers.count; i++) {
        if (i >= insertNumber) {
            UIViewController *childController = self.myChildViewControllers[i];
            childController.view.frame = CGRectMake(screenW * (i+1), 0, screenW, scrollViewHeight);
            [self.scrollView addSubview:childController.view];
        }
    }
    if (insertNumber <= self.pageMenu.selectedItemIndex && self.myChildViewControllers.count) { // 如果新插入的item在当前选中的item之前
        // scrollView往后偏移
        self.scrollView.contentOffset = CGPointMake(screenW*(self.pageMenu.selectedItemIndex+1), 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    SixViewController *sixVc = [[SixViewController alloc] init];
    sixVc.text = @"我是新插入的";
    [self addChildViewController:sixVc];
    [self.myChildViewControllers insertObject:sixVc atIndex:insertNumber];
    
    // 要先添加控制器，再添加item，如果先添加item，会立即调代理方法，此时myChildViewControllers的个数还是0，在代理方法中retun了
    if ([object isKindOfClass:[NSString class]]) {
        [self.pageMenu insertItemWithTitle:object atIndex:insertNumber animated:YES];
    } else {
        [self.pageMenu insertItemWithImage:object atIndex:insertNumber animated:YES];
    }
    
    // 重新设置scrollView容量
    self.scrollView.contentSize = CGSizeMake(screenW*self.myChildViewControllers.count, 0);
}

- (void)removeItemAtIndex:(NSInteger)index {
    
    if (index >= self.myChildViewControllers.count) {
        return;
    }
    
    [self.pageMenu removeItemAtIndex:index animated:YES];
    
    // 删除之前，先将新控制器之后的控制器view往前偏移
    for (int i = 0; i < self.myChildViewControllers.count; i++) {
        if (i >= index) {
            UIViewController *childController = self.myChildViewControllers[i];
            childController.view.frame = CGRectMake(screenW * (i>0?(i-1):i), 0, screenW, scrollViewHeight);
            [self.scrollView addSubview:childController.view];
        }
    }
    if (index <= self.pageMenu.selectedItemIndex) { // 移除的item在当前选中的item之前
        // scrollView往前偏移
        NSInteger offsetIndex = self.pageMenu.selectedItemIndex-1;
        if (offsetIndex < 0) {
            offsetIndex = 0;
        }
        self.scrollView.contentOffset = CGPointMake(screenW*offsetIndex, 0);
    }
    
    UIViewController *vc = [self.myChildViewControllers objectAtIndex:index];
    [self.myChildViewControllers removeObjectAtIndex:index];
    [vc removeFromParentViewController];
    [vc.view removeFromSuperview];
    
    // 重新设置scrollView容量
    self.scrollView.contentSize = CGSizeMake(screenW*self.myChildViewControllers.count, 0);
}

- (void)removeAllItems {
    [self.pageMenu removeAllItems];
    for (UIViewController *vc in self.myChildViewControllers) {
        [vc removeFromParentViewController];
        [vc.view removeFromSuperview];
    }
    [self.myChildViewControllers removeAllObjects];
    
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.contentSize = CGSizeMake(0, 0);
    
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 这一步是实现跟踪器时刻跟随scrollView滑动的效果,如果对self.pageMenu.scrollView赋了值，这一步可省
    // [self.pageMenu moveTrackerFollowScrollView:scrollView];
}

#pragma mark - getter

- (NSMutableArray *)myChildViewControllers {
    
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
        
    }
    return _myChildViewControllers;
}

- (void)dealloc {
    NSLog(@"父控制器被销毁了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
