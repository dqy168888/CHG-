//
//  UITextField+CHGExtension.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/12.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "UITextField+CHGExtension.h"


/** 占位文字颜色 */
static NSString * const CHGPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (CHGExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    BOOL change = NO;
    
    // 保证有占位文字
    if (self.placeholder == nil) {
        self.placeholder = @" ";
        change = YES;
    }
    
    // 设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:CHGPlaceholderColorKey];
    
    // 恢复原状
    if (change) {
        self.placeholder = nil;
    }
}

- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:CHGPlaceholderColorKey];
}
@end
