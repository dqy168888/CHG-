//
//  CHGPostWordViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/10.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGPostWordViewController.h"
#import "CHGPlaceholderTextView.h"

@interface CHGPostWordViewController ()

@end

@implementation CHGPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.view.backgroundColor = CHGRandomColor;
    
    CHGPlaceholderTextView *textView = [[CHGPlaceholderTextView alloc] init];
//    textView.frame = self.view.bounds;
    textView.frame = CGRectMake(100, 100, 200, 200);
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:textView];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
