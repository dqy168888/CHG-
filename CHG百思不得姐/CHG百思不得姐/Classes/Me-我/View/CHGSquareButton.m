//
//  CHGSquareButton.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/7.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGSquareButton.h"
#import "CHGSquare.h"
#import <UIButton+WebCache.h>

@implementation CHGSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置按钮label的对齐方式
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 设置按钮背景图片  本图片自带分割线
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.y = self.height * 0.1;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.width = self.width;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x = 0;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquare:(CHGSquare *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    // 设置按钮的image
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
    
}

@end
