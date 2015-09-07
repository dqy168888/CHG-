//
//  CHGMeViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGMeViewController.h"
#import "CHGSetingTableViewController.h"
#import "CHGMeCell.h"
#import "CHGMeFooter.h"


@interface CHGMeViewController ()

@end

@implementation CHGMeViewController

static NSString * const meCell = @"meCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupNav];
}

- (void)setupTable
{
    // 设置背景颜色
    self.view.backgroundColor = CHGGlobalBg;
    
    // 注册cell
    [self.tableView registerClass:[CHGMeCell class] forCellReuseIdentifier:meCell];
    
    self.tableView.sectionHeaderHeight = CHGCommonMargin;
    
    self.tableView.sectionFooterHeight = 0;
    
    // 设置内边距(-25代表：所有内容往上移动25)
    self.tableView.contentInset = UIEdgeInsetsMake(CHGCommonMargin - 35, 0, 0, 0);
    // 设置footer
    self.tableView.tableFooterView = [[CHGMeFooter alloc] init];
    
}

- (void)setupNav
{
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *nightModeItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon"highImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightModeItem];
}

- (void)settingClick
{
    CHGSetingTableViewController *vc = [[CHGSetingTableViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;// 当push这个控制器时,会自动隐藏底部的工具条
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)nightModeClick
{
    CHGLogFunc;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHGMeCell *cell = [tableView dequeueReusableCellWithIdentifier:meCell];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    } else {
        cell.textLabel.text = @"离线下载";
    }
        
    return cell;
}

@end
