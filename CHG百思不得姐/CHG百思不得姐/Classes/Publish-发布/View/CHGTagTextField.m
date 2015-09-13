//
//  CHGTagTextField.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/13.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  添加标签的textfield

#import "CHGTagTextField.h"

@implementation CHGTagTextField
/**
 * 监听键盘内部的删除键点击
 */
- (void)deleteBackward
{
    // 执行需要做的操作
    !self.deleteBackwardOperation ? : self.deleteBackwardOperation();
    
    [super deleteBackward];
}

@end
