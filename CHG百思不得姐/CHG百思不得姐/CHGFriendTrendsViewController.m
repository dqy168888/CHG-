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
    
    UIBarButtonItem *tagItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(tagClick)];
    
    self.navigationItem.leftBarButtonItem = tagItem;
}

- (void)tagClick
{
    CHGLogFunc;
}

@end
