//
//  CHGQuickLoginButton.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/4.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGQuickLoginButton.h"

@implementation CHGQuickLoginButton


- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
