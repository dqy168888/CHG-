//
//  CHGLoginRegisterViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/2.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGLoginRegisterViewController.h"

@interface CHGLoginRegisterViewController ()

@end

@implementation CHGLoginRegisterViewController

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
