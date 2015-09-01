//
//  CHGFriendTrendsViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGFriendTrendsViewController.h"

@interface CHGFriendTrendsViewController ()

@end

@implementation CHGFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关注";
    
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    tagButton.size = tagButton.currentBackgroundImage.size;
    [tagButton addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tagButton];
}

- (void)tagClick
{
    CHGLogFunc;
}

@end
