//
//  CHGLoginRegisterViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/2.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  注册登录

#import "CHGLoginRegisterViewController.h"

@interface CHGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;

@end

@implementation CHGLoginRegisterViewController

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

 
- (IBAction)loginRegisterBtn:(UIButton *)btn {
    if (self.leftSpace.constant == 0) {
        self.leftSpace.constant = - self.view.width;
        btn.selected = YES;
    }else
    {
        self.leftSpace.constant = 0;
        btn.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

// 即将显示前 改变状态栏样式
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}



//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
