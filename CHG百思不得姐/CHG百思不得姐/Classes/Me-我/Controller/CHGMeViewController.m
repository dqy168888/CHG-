//
//  CHGMeViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGMeViewController.h"
#import "CHGSetingTableViewController.h"


@interface CHGMeViewController ()

@end

@implementation CHGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *nightModeItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon"highImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightModeItem];
    
    // 设置背景颜色
    self.view.backgroundColor = CHGGlobalBg;
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


@end
