//
//  CHGLoginRegisterTextField.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/4.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGLoginRegisterTextField.h"

@implementation CHGLoginRegisterTextField


- (void)awakeFromNib
{
    // 文本框的光标颜色
    self.tintColor = [UIColor whiteColor];
    // 文字颜色
    self.textColor = [UIColor whiteColor];
    // 设置带有属性的占位文字(富文本)
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
    
    // 设置占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    
    // 通过addTarget:-》监听文本框的开始和结束编辑
    [self addTarget:self action:@selector(beginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventEditingDidEnd];
}

//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    // 占位文字画在哪个矩形框里面
//    CGRect placeholderRect = self.bounds;
//    placeholderRect.origin.y = (self.height - self.font.lineHeight) * 0.5;
//    
//    // 文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
//    attrs[NSFontAttributeName] = self.font;
//    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
//}

- (void)beginEditing
{
    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
}

- (void)endEditing
{
    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
}


@end
