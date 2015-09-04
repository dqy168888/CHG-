//
//  CHGLoginRegisterTextField.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/4.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGLoginRegisterTextField.h"

#define CHGPlaceholderColorKey @"placeholderLabel.textColor"
// 默认的占位文字颜色
#define CHGPlaceholderDefaultColor [UIColor grayColor]
// 聚焦的占位文字颜色
#define CHGPlaceholderFocusColor [UIColor whiteColor]

@implementation CHGLoginRegisterTextField

- (void)awakeFromNib
{
    // 文本框的光标颜色
    self.tintColor = CHGPlaceholderFocusColor;
    // 文字颜色
    self.textColor = CHGPlaceholderFocusColor;

    [self resignFirstResponder];
    
//    // 设置占位文字颜色
//    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    
    
//    // 通过addTarget:-》监听文本框的开始和结束编辑
//    [self addTarget:self action:@selector(beginEditing) forControlEvents:UIControlEventEditingDidBegin];
//    [self addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventEditingDidEnd];
}


// 弹出当前文本框对应的键盘时调用
- (BOOL)becomeFirstResponder
{
    [self setValue:CHGPlaceholderFocusColor forKeyPath:CHGPlaceholderColorKey];
    return [super becomeFirstResponder];
}

// 隐藏当前文本框对应的键盘时调用
- (BOOL)resignFirstResponder
{
    [self setValue:CHGPlaceholderDefaultColor forKeyPath:CHGPlaceholderColorKey];
    return [super resignFirstResponder];
}

//- (void)beginEditing
//{
//    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
//}
//
//- (void)endEditing
//{
//    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
//}


@end
