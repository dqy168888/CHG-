//
//  CHGAddTagViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/12.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  添加标签

#import "CHGAddTagViewController.h"

@interface CHGAddTagViewController ()

@end

@implementation CHGAddTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    [self setupTextField];
    
}

- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.x = CHGCommonSmallMargin;
    textField.y = CHGNavBarMaxY + CHGCommonSmallMargin;
    textField.width = self.view.width - 2 * CHGCommonSmallMargin;
    textField.height = CHGTagH;
    
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.placeholderColor = [UIColor grayColor];
    
    [textField becomeFirstResponder];
    
    [self.view addSubview:textField];
    // 刷新的前提：这个控件已经被添加到父控件
    [textField layoutIfNeeded];
}

- (void)setupNav
{
    self.title = @"添加标签";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc ] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc ] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}



- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done
{
    
}

@end
