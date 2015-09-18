//
//  CHGCommentHeaderView.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/18.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGCommentHeaderView.h"

@interface CHGCommentHeaderView ()
/** 内部的label */
@property (nonatomic, weak) UILabel *label;

@end
@implementation CHGCommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = CHGGlobalBg;
        
        UILabel *label = [[UILabel alloc] init];
        label.x = CHGCommonMargin;
        // 自动伸缩
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.textColor = CHGGrayColor(100);
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        self.label = label;
    }
    
    return self;
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    self.label.text = text;
}


@end
