//
//  CHGNewViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGNewViewController.h"

@interface CHGNewViewController ()

@end

@implementation CHGNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    UIBarButtonItem *tagItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.navigationItem.leftBarButtonItem = tagItem;
    
    // 设置背景颜色
    self.view.backgroundColor = CHGGlobalBg;
}

- (void)tagClick
{
    CHGLogFunc;
}


@end
