//
//  CHGTitleButton.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/13.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGTitleButton.h"

@implementation CHGTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted { }

@end
