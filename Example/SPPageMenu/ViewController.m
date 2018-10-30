//
//  ViewController.m
//  SPPageMenu
//
//  Created by 乐升平 on 17/10/26.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ViewController.h"
#import "ParentViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
    
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    tableView.sectionFooterHeight = CGFLOAT_MIN;
    
    self.titles = @[@"跟踪器样式专区",@"排列方式专区",@"跟踪器跟踪模式专区",@"右侧功能按钮(插入和删除操作)",@"其余功能",@"特别属性"];
    self.dataSource = @[@[@"下划线与按钮等宽(默认)",@"下划线比按钮略长",@"下划线“依恋”样式",@"缩放",@"圆角矩形",@"圆角矩形（与pageMenu同时圆角）",@"矩形",@"无样式"],@[@"可滑动的自适应内容排列",@"不可滑动的等宽排列",@"不可滑动的自适应内容排列"],@[@"跟踪器时刻跟随外界scrollView移动",@"外界scrollVie拖动结束后，跟踪器才开始移动",@"外界scrollView拖动距离超过屏幕一半时，跟踪器开始移动"],@[@"显示右侧功能按钮",@"给功能按钮设置图片和文字"],@[@"含有图片的按钮",@"指定按钮携带图片,或同时携带图片和文字,可以设置图片的位置",@"设置背景图片",@"角标"],@[@"bridgeScrollView属性"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 60;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ParentViewController *parentVc = [[ParentViewController alloc] init];
    NSInteger testNumber = indexPath.row;
    int i = 1;
    while (i <= indexPath.section) {
        testNumber += [self.dataSource[indexPath.section-i] count];
        i++;
    }
    parentVc.testNumber = testNumber;
    [self.navigationController pushViewController:parentVc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = self.titles[section];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}


@end
