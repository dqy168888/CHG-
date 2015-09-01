//
//  CHGTabBar.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGTabBar.h"

@interface CHGTabBar()
@property (nonatomic, strong) UIButton *publishButton;
@end

@implementation CHGTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateNormal];
        
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置发布按钮的frame
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);

    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
//        CGFloat buttonX = (index > 1) ? (buttonW * index) : (buttonW * (index + 1));
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index ++;
    }
}
@end
