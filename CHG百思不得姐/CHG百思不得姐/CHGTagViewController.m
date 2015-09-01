//
//  CHGTagViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGTagViewController.h"

@interface CHGTagViewController ()

@end

@implementation CHGTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    self.navigationItem.title = @"推荐标签";
    
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setTitle:@"返回" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [Button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [Button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [Button sizeToFit];
    [Button addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
    Button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:Button];
}

- (void)tagClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
