//
//  CHGRecommendCategoryCell.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/6.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGRecommendCategoryCell.h"
#import "CHGRecommendCategory.h"

@interface CHGRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *SelectedIndicator;

@end

@implementation CHGRecommendCategoryCell

- (void)awakeFromNib {
    
    // 清除文字背景颜色
    self.textLabel.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.textLabel.textColor = selected ?[UIColor redColor] : [UIColor grayColor];
    self.SelectedIndicator.hidden = !selected;
    
}

- (void)setCategory:(CHGRecommendCategory *)category{
    
    _category = category;
    
    // 设置文字
    self.textLabel.text = category.name;
    
}
@end
