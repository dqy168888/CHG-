//
//  CHGFriendTrendsViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGFriendTrendsViewController.h"
#import "CHGRecommendController.h"

@interface CHGFriendTrendsViewController ()

@end

@implementation CHGFriendTrendsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    
    UIBarButtonItem *tagItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(tagClick)];
    
    self.navigationItem.leftBarButtonItem = tagItem;
    
    // 设置背景颜色
    self.view.backgroundColor = CHGGlobalBg;
}

- (void)tagClick
{
    CHGRecommendController *vc = [[CHGRecommendController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
