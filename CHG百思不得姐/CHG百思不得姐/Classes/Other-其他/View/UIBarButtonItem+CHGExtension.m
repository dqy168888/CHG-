//
//  UIBarButtonItem+CHGExtension.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "UIBarButtonItem+CHGExtension.h"

@implementation UIBarButtonItem (CHGExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    Button.size = Button.currentBackgroundImage.size;
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:Button];
}

@end
