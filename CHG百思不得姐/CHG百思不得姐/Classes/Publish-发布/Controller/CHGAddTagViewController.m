//
//  CHGAddTagViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/12.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  添加标签

#import "CHGAddTagViewController.h"
#import "CHGTagButton.h"
#import "CHGTagTextField.h"
#import <SVProgressHUD.h>

@interface CHGAddTagViewController ()<UITextFieldDelegate>
/** 用来容纳所有按钮和文本框 */
@property (nonatomic, weak) UIView *contentView;
/** 文本框 */
@property (nonatomic, weak) CHGTagTextField *textField;
/** 提醒按钮 */
@property (nonatomic, weak) UIButton *tipButton;
/** 存放所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;

@end

@implementation CHGAddTagViewController
#pragma mark 懒加载
- (NSMutableArray *)tagButtons
{
    if (_tagButtons == nil) {
        _tagButtons = [NSMutableArray array];
    }
    return  _tagButtons;
}

- (UIButton *)tipButton
{
    if (!_tipButton) {
        // 创建一个提醒按钮
        UIButton *tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tipButton addTarget:self action:@selector(tipClick) forControlEvents:UIControlEventTouchUpInside];
        tipButton.width = self.contentView.width;
        tipButton.height = CHGTagH;
        tipButton.x = 0;
        tipButton.backgroundColor = CHGTagBgColor;
        tipButton.titleLabel.font = [UIFont systemFontOfSize:14];
        //        tipButton.titleLabel.textAlignment = NSTextAlignmentLeft; // 不可行
        // 文字居左
        tipButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        tipButton.contentEdgeInsets = UIEdgeInsetsMake(0, CHGCommonSmallMargin, 0, 0);
        [self.contentView addSubview:tipButton];
        _tipButton = tipButton;
    }
    return _tipButton;
}


#pragma mare 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
 
    // 下面这两个控件设置有先后顺序
    [self setupContentView];
    [self setupTextField];
    
    [self setupTags];
    
}

- (void)setupTags
{
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self tipClick];
    }
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = CHGCommonSmallMargin;
    contentView.y = CHGNavBarMaxY + CHGCommonSmallMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.height = self.view.height;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupTextField
{
    CHGTagTextField *textField = [[CHGTagTextField alloc] init];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    textField.width = self.contentView.width;
    textField.height = CHGTagH;
    
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.placeholderColor = [UIColor grayColor];
    self.textField = textField;
    
    textField.delegate = self;
    [textField becomeFirstResponder];
    
    [self.contentView addSubview:textField];
    // 刷新的前提：这个控件已经被添加到父控件
    [textField layoutIfNeeded];
    
    
    CHGWeakSelf;
    // 设置点击删除键需要执行的操作
    textField.deleteBackwardOperation = ^{
        // 判断文本框是否有文字 或者在没有标签时的情况下
//        if (weakSelf.textField.hasText) return;// 直接回删tipButton会显示出来
        if (weakSelf.textField.hasText || weakSelf.tagButtons.count == 0) return;
        
        // 点击了最后一个标签按钮（删掉最后一个标签按钮）
        [weakSelf tagClick:weakSelf.tagButtons.lastObject];
    };
}

- (void)setupNav
{
    self.title = @"添加标签";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc ] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc ] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}


#pragma mark 监听
// 输入文字时设置提醒按钮的 位置和内容
- (void)textDidChange
{
    // 提醒按钮
    if (self.textField.hasText) {
        NSString *text = self.textField.text;
        NSString *lastChar = [text substringFromIndex:text.length - 1];
        if ([lastChar isEqualToString:@","]
            || [lastChar isEqualToString:@"，"]) { // 最后一个输入的字符是逗号
            // 去掉文本框最后一个逗号
//            self.textField.text = [text substringToIndex:text.length - 1];
            [self.textField deleteBackward];
            
            // 点击提醒按钮
            [self tipClick];
        } else { // 最后一个输入的字符不是逗号
            // 排布文本框
            [self setupTextFieldFrame];
            
            self.tipButton.hidden = NO;
            [self.tipButton setTitle:[NSString stringWithFormat:@"添加标签：%@", text] forState:UIControlStateNormal];
        }
    } else {
        self.tipButton.hidden = YES;
    }
}

// 点击提醒按钮
- (void)tipClick
{
    // 如果不判断  换行或者逗号会创建 一个空的标签
    if (self.textField.hasText == NO) return;
    
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    // 添加标签按钮
    CHGTagButton *newTagButton = [[CHGTagButton alloc] init];
    [newTagButton setTitle:[NSString stringWithFormat:@"%@", self.textField.text] forState:UIControlStateNormal];
    [newTagButton addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:newTagButton];

    // 设置按钮的位置
    // 最后一个标签按钮
    CHGTagButton *lastTagutton = self.tagButtons.lastObject;
    [self setupTagButtonFrame:newTagButton referenceTagButton:lastTagutton];
    
    // 将新创建的按钮添加到数组中
    [self.tagButtons addObject:newTagButton];
    
    // 调整textfield的位置
    [self setupTextFieldFrame];
    self.textField.text = nil;
    
    self.tipButton.hidden = YES;
}

/**
 点击了标签按钮
 */
- (void)tagClick:(CHGTagButton *)clickedTagButton
{
    // 即将被删除的标签按钮的索引
    NSUInteger index = [self.tagButtons indexOfObject:clickedTagButton];
    
    // 删除按钮
    [clickedTagButton removeFromSuperview];
    [self.tagButtons removeObject:clickedTagButton];
    
    // 处理后面的标签按钮
    for (NSUInteger i = index; i < self.tagButtons.count; i++) {
        CHGTagButton *tagButton = self.tagButtons[i];
        // 如果i不为0，就参照上一个标签按钮
        CHGTagButton *previousTagButton = (i == 0) ? nil : self.tagButtons[i - 1];
        [self setupTagButtonFrame:tagButton referenceTagButton:previousTagButton];
    }
    
    // 排布文本框
    [self setupTextFieldFrame];
}


- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done
{
    // 将self.tagButtons中存放的所有对象的currentTitle属性值取出来，放到一个新的数组中，并返回
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.getTagsBlock ? :self.getTagsBlock(tags);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 设置控件的frame
/**
 * 设置标签按钮的frame
 * @param tagButton 需要设置frame的标签按钮
 * @param referenceTagButton 计算tagButton的frame时参照的标签按钮
 */
- (void)setupTagButtonFrame:(CHGTagButton *)tagButton referenceTagButton:(CHGTagButton *)referenceTagButton
{
    // 没有参照按钮（tagButton是第一个标签按钮）
    if (referenceTagButton == nil) {
        tagButton.x = 0;
        tagButton.y = 0;
        return;
    }
    
    // tagButton不是第一个标签按钮
    CGFloat leftWidth = CGRectGetMaxX(referenceTagButton.frame) + CHGCommonSmallMargin;
    CGFloat rightWidth = self.contentView.width - leftWidth;
    if (rightWidth >= tagButton.width) { // 跟上一个标签按钮处在同一行
        tagButton.x = leftWidth;
        tagButton.y = referenceTagButton.y;
    } else { // 下一行
        tagButton.x = 0;
        tagButton.y = CGRectGetMaxY(referenceTagButton.frame) + CHGCommonSmallMargin;
    }
}

/**
 * 设置文本框的frame
 */
- (void)setupTextFieldFrame
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    textW = MAX(100, textW);
    
    CHGTagButton *lastTagButton = self.tagButtons.lastObject;
    if (lastTagButton == nil) { // 没有标签时
        self.textField.x = 0;
        self.textField.y = 0;
    }else
    {
        CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + CHGCommonSmallMargin;
        CGFloat rightWidth = self.contentView.width - leftWidth;
        if (rightWidth >= textW) { // 跟新添加的标签按钮处在同一行
            self.textField.x = leftWidth;
            self.textField.y = lastTagButton.y;
        } else { // 换行
            self.textField.x = 0;
            self.textField.y = CGRectGetMaxY(lastTagButton.frame) + CHGCommonSmallMargin;
        }
    }
    
    // 排布提醒按钮
    self.tipButton.y = CGRectGetMaxY(self.textField.frame) + CHGCommonSmallMargin;
}

#pragma mark - <UITextFieldDelegate>
/**
 点击右下角return按钮就会调用这个方法  ps：千万不要忘记设置代理。。。不然你会发现你的换行失灵了 2333333
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self tipClick];
    return YES;
}

@end
