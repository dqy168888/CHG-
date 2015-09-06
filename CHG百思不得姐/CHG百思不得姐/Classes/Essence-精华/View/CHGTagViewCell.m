//
//  CHGTagViewCell.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/6.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGTagViewCell.h"
#import "CHGTag.h"
#import <UIImageView+WebCache.h>

@interface CHGTagViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation CHGTagViewCell

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


- (void)setTag:(CHGTag *)Tag
{
    _Tag = Tag;

    self.themeNameLabel.text = Tag.theme_name;
    // 设置订阅数
    if (Tag.sub_number > 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅",Tag.sub_number / 10000.0];
    }else
    {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅",Tag.sub_number];
    }
    
    [self.imageListView sd_setImageWithURL:[NSURL URLWithString:Tag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
