//
//  CHGChiBaoZiFooter.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/15.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGChiBaoZiFooter.h"

@implementation CHGChiBaoZiFooter

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
