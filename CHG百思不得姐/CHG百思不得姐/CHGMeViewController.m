//
//  CHGMeViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGMeViewController.h"


@interface CHGMeViewController ()

@end

@implementation CHGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *nightModeItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon"highImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightModeItem];
}

- (void)settingClick
{
    CHGLogFunc;
}

- (void)nightModeClick
{
    CHGLogFunc;
}


@end
