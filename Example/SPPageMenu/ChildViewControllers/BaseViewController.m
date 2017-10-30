//
//  BaseViewController.m
//  SPPageMenu
//
//  Created by 乐升平 on 17/10/26.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSStringFromClass([self class]) stringByAppendingString:@"cell"]];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSStringFromClass([self class]) stringByAppendingString:@"cell"]];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@------第%zd行",_text,indexPath.row];
    if ([_text isEqualToString:@"图片"]) {
        cell.detailTextLabel.text = @"注:这是图片不是emoji哦";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    } else {
        cell.detailTextLabel.text = nil;
    }
    cell.textLabel.alpha = 0.7;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}


@end
