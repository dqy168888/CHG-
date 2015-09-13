//
//  CHGPlaceholderTextView2.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/10.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  发段子的textView

#import "CHGPlaceholderTextView2.h"


@interface CHGPlaceholderTextView2 ()

/** 占位文字label */
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation CHGPlaceholderTextView2

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 创建label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        // 设置默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 设置默认颜色
        self.placeholderColor = [UIColor grayColor];
        
        // 使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange:(NSNotification *)note
{
    self.placeholderLabel.hidden = self.hasText;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLabel.x = 5;
    self.placeholderLabel.y = 8;
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

#pragma mark - setter
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    [self.placeholderLabel sizeToFit];
    //    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    [self.placeholderLabel sizeToFit];
    //    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    self.placeholderLabel.hidden = self.hasText;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    self.placeholderLabel.hidden = self.hasText;
}

@end
