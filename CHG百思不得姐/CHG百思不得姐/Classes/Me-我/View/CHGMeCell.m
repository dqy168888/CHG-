//
//  CHGMeCell.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/7.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGMeCell.h"

@implementation CHGMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 设置箭头样式
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.textColor = [UIColor darkGrayColor];
        
        // 设置背景图片(图片拉伸方式水平和竖直)
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    // 调整imageView
    self.imageView.y = CHGCommonMargin * 0.5;
    self.imageView.height = self.contentView.height - 2 * self.imageView.y;
    self.imageView.width = self.imageView.height;
    
    // 调整Label
    //    self.textLabel.x = self.imageView.x + self.imageView.width + CHGCommonMargin;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + CHGCommonMargin;
    
    // CGRectGetMaxX(self.imageView.frame) == self.imageView.x + self.imageView.width
    // CGRectGetMinX(self.imageView.frame) == self.imageView.x
    // CGRectGetMidX(self.imageView.frame) == self.imageView.x + self.imageView.width * 0.5
    // CGRectGetMidX(self.imageView.frame) == self.imageView.centerX
}


@end
