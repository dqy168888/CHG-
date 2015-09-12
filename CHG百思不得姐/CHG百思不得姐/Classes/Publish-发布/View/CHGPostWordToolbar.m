//
//  CHGPostWordToolbar.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/11.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  发段子  辅助工具

#import "CHGPostWordToolbar.h"
#import "CHGAddTagViewController.h"
#import "CHGNavigationController.h"
#import "CHGPostWordViewController.h"

@interface CHGPostWordToolbar ()

@property (weak, nonatomic) IBOutlet UIView *top;

@end
@implementation CHGPostWordToolbar

- (void)awakeFromNib
{
    // 添加加号按钮
    UIButton *addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addbutton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addbutton sizeToFit];
    [addbutton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.top addSubview:addbutton];
}

- (void)addClick
{
    // A --modal--> B
    // A.presentedViewController == B
    // B.presentingViewController == A
    
    CHGAddTagViewController *addtagVC = [[CHGAddTagViewController alloc] init];
    CHGNavigationController *nav = [[CHGNavigationController alloc] initWithRootViewController:addtagVC];
    
    // 拿到"窗口根控制器"曾经modal出来的“发表文字”所在的导航控制器
    CHGPostWordViewController *postwordVC = (CHGPostWordViewController *)self.window.rootViewController.presentedViewController;
    [postwordVC presentViewController:nav animated:YES completion:nil];
}


@end
