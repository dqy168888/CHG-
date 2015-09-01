//
//  CHGEssenceViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGEssenceViewController.h"

@interface CHGEssenceViewController ()

@end

@implementation CHGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    tagButton.size = tagButton.currentBackgroundImage.size;
    [tagButton addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tagButton];
}

- (void)tagClick
{
    CHGLogFunc;
}

@end
