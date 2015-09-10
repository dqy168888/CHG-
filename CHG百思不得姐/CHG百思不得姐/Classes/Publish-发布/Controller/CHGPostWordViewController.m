//
//  CHGPostWordViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/10.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGPostWordViewController.h"
#import "CHGPlaceholderTextView.h"

@interface CHGPostWordViewController ()<UITextViewDelegate>
/** 文本框 */
@property (nonatomic, weak) CHGPlaceholderTextView *textView;
@end

@implementation CHGPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    // 强制更新(能马上刷新现在的状态)
    [self.navigationController.navigationBar layoutIfNeeded];
    [self setupTextView];
}


- (void)setupTextView
{
    CHGPlaceholderTextView *textView = [[CHGPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    // 不管内容有多少，竖直方向上永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
//    textView.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:textView];
    
    UISwitch *swich = [[UISwitch alloc] init];
    swich.frame = CGRectMake(100, 200, 0, 0);
    [textView addSubview:swich];
    
    self.textView = textView;
}

- (void)post
{
    CHGLogFunc;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UITextViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
    CHGLogFunc;
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}




@end
