//
//  CHGPostWordToolbar.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/11.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  发段子  辅助工具

#import "CHGPostWordToolbar.h"
#import "CHGAddTagViewController.h"
#import "CHGNavigationController.h"
#import "CHGPostWordViewController.h"

@interface CHGPostWordToolbar ()

@property (weak, nonatomic) IBOutlet UIView *top;
/** 所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;
/** 加号按钮 */
@property (nonatomic, weak) UIButton *addButton;
@end
@implementation CHGPostWordToolbar

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib
{
    // 添加加号按钮
    UIButton *addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addbutton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addbutton sizeToFit];
    [addbutton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.top addSubview:addbutton];
    self.addButton = addbutton;
}

- (void)addClick
{
    // A --modal--> B
    // A.presentedViewController == B
    // B.presentingViewController == A
    
    CHGAddTagViewController *addtagVC = [[CHGAddTagViewController alloc] init];
    
    // 这段代码保存的功能是：在toolbar中创建标签label
    addtagVC.getTagsBlock = ^(NSArray *tags){
        
        [self createTagLabels:tags];
    };
    CHGNavigationController *nav = [[CHGNavigationController alloc] initWithRootViewController:addtagVC];
    
    
    // 拿到"窗口根控制器"曾经modal出来的“发表文字”所在的导航控制器
    CHGPostWordViewController *postwordVC = (CHGPostWordViewController *)self.window.rootViewController.presentedViewController;
    [postwordVC presentViewController:nav animated:YES completion:nil];
}

/**
 * 创建标签label
 */
- (void)createTagLabels:(NSArray *)tags
{
    // 每次点击完成添加标签label之前将原来的label标签全部从父控件移除 并且清空标签数组
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i < tags.count; ++i) {
        // 创建label
        UILabel *newTagLabel = [[UILabel alloc] init];
        newTagLabel.text = tags[i];
        newTagLabel.font = [UIFont systemFontOfSize:14];
        newTagLabel.backgroundColor = CHGTagBgColor;
        newTagLabel.textColor = [UIColor whiteColor];
        newTagLabel.textAlignment = NSTextAlignmentCenter;
        [self.top addSubview:newTagLabel];
        [self.tagLabels addObject:newTagLabel];
        
        
        // 设置label的frame
        // 尺寸
        [newTagLabel sizeToFit];
        newTagLabel.height = CHGTagH;
        newTagLabel.width = newTagLabel.width + CHGCommonSmallMargin * 2 ;
        
        // 位置
        if (i == 0) {
            newTagLabel.x = 0;
            newTagLabel.y = 0;
        } else {
            // 上一个标签
            UILabel *previousTagLabel = self.tagLabels[i - 1];
            CGFloat leftWidth = CGRectGetMaxX(previousTagLabel.frame) + CHGCommonSmallMargin;
            CGFloat rightWidth = self.top.width - leftWidth;
            if (rightWidth >= newTagLabel.width) {
                newTagLabel.x = leftWidth;
                newTagLabel.y = previousTagLabel.y;
            } else {
                newTagLabel.x = 0;
                newTagLabel.y = CGRectGetMaxY(previousTagLabel.frame) + CHGCommonSmallMargin;
            }
        }
    }
    
    // 调整加号按钮
    UILabel *lastTagLabel = self.tagLabels.lastObject;
    if (lastTagLabel == nil) { // 没有标签时
        self.addButton.x = 0;
        self.addButton.y = 0;
    }else
    {
        CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + CHGCommonSmallMargin;
        CGFloat rightWidth = self.top.width - leftWidth;
        if (rightWidth >= self.addButton.width) { // 跟新添加的标签按钮处在同一行
            self.addButton.x = leftWidth;
            self.addButton.y = lastTagLabel.y;
        } else { // 换行
            self.addButton.x = 0;
            self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + CHGCommonSmallMargin;
        }
    }
}

@end
