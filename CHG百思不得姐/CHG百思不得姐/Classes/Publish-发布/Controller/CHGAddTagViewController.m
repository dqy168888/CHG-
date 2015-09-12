//
//  CHGAddTagViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/12.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  添加标签

#import "CHGAddTagViewController.h"
#import "CHGTagButton.h"

@interface CHGAddTagViewController ()<UITextFieldDelegate>
/** 用来容纳所有按钮和文本框 */
@property (nonatomic, weak) UIView *contentView;
/** 文本框 */
@property (nonatomic, weak) UITextField *textField;
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
    UITextField *textField = [[UITextField alloc] init];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    textField.width = self.contentView.width;
    textField.height = CHGTagH;
    
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.placeholderColor = [UIColor grayColor];
    self.textField = textField;
    
    [textField becomeFirstResponder];
    
    [self.contentView addSubview:textField];
    // 刷新的前提：这个控件已经被添加到父控件
    [textField layoutIfNeeded];
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
    if (self.textField.hasText) {
        self.tipButton.hidden = NO;
        self.tipButton.y = CGRectGetMaxY(self.textField.frame) + CHGCommonSmallMargin;
        [self.tipButton setTitle:[NSString stringWithFormat:@"添加标签：%@", self.textField.text] forState:UIControlStateNormal];
        
    }else
    {
        self.tipButton.hidden = YES;
    }
}

// 点击提醒按钮
- (void)tipClick
{
    // 添加标签按钮
    CHGTagButton *newTagButton = [[CHGTagButton alloc] init];
    [newTagButton setTitle:[NSString stringWithFormat:@"%@", self.textField.text] forState:UIControlStateNormal];
    [newTagButton addTarget:self action:@selector(deletebutton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:newTagButton];

    // 设置按钮的位置
    // 最后一个标签按钮
    UIButton *lastTagutton = self.tagButtons.lastObject;
    if (lastTagutton) { // 不是第一个标签
        // 左边的总宽度
        CGFloat leftWidth = CGRectGetMaxX(lastTagutton.frame) + CHGCommonSmallMargin;
        // 右边剩下的宽度
        CGFloat rightWidth = self.contentView.width - leftWidth;
        if (rightWidth >= newTagButton.width) { // 跟最后一个按钮处在同一行
            newTagButton.x = leftWidth;
            newTagButton.y = lastTagutton.y;
        } else { // 下一行
            newTagButton.x = 0;
            newTagButton.y = CGRectGetMaxY(lastTagutton.frame) + CHGCommonSmallMargin;
        }
    } else { // 第一个标签按钮
        newTagButton.x = 0;
        newTagButton.y = 0;
    }
    
    // 将新创建的按钮添加到数组中
    [self.tagButtons addObject:newTagButton];
    
    // 调整textfield的位置
    // 左边的总宽度
    CGFloat leftWidth = CGRectGetMaxX(newTagButton.frame) + CHGCommonSmallMargin;
    // 右边剩下的宽度
    CGFloat rightWidth = self.contentView.width - leftWidth;
    
    if (rightWidth >= 100) { // 跟新添加的标签按钮处在同一行
        self.textField.x = leftWidth;
        self.textField.y = newTagButton.y;
    }else
    {   // 先标签的下一行
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(newTagButton.frame) + CHGCommonSmallMargin;
    }
    
    self.textField.text = nil;
    
    self.tipButton.hidden = YES;
}

// 删除标签时
- (void)deletebutton
{

}


- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done
{
    CHGLog(@"点击了发表按钮");
}


/**
 点击右下角return按钮就会调用这个方法
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self tipClick];
    CHGLog(@"%s",__func__);
    return YES;
}
@end
