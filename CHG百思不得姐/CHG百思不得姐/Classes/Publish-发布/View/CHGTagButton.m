//
//  CHGTagButton.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/12.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  标签按钮  title和image交换位置

#import "CHGTagButton.h"

@implementation CHGTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = CHGTagBgColor;
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 自动计算
    [self sizeToFit];
    
    // 微调
    self.height = CHGTagH;
    self.width += 3 * CHGCommonSmallMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = CHGCommonSmallMargin;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + CHGCommonSmallMargin;
}

@end
