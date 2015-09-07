//
//  CHGMeFooter.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/7.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGMeFooter.h"
#import "CHGSquare.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "CHGSquareButton.h"
#import <UIButton+WebCache.h>

@implementation CHGMeFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        // 请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        CHGWeakSelf;
        [[AFHTTPSessionManager manager] GET:CHGRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            // 转模型后将数组传入创建方块
            [weakSelf createSquares:[CHGSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]]];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    return self;
}

/**
 * 创建方块
 */
- (void)createSquares:(NSArray *)squares
{ // 每行的列数
    int colsCount = 4;
    
    // 按钮尺寸
    CGFloat buttonW = self.width / colsCount;
    CGFloat buttonH = buttonW;
    
    // 遍历所有的模型
    NSUInteger count = squares.count;
    for (NSUInteger i = 0; i < count; i++) {
        CHGSquare *square = squares[i];
        
        // 创建按钮
        CHGSquareButton *button = [CHGSquareButton buttonWithType:UIButtonTypeCustom];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        // frame
        CGFloat buttonX = (i % colsCount) * buttonW;
        CGFloat buttonY = (i / colsCount) * buttonH;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 数据
        [button setTitle:square.name forState:UIControlStateNormal];
        // 设置按钮的image
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
        
        // 错误示范
        //        [button.imageView sd_setImageWithURL:[NSURL URLWithString:square.icon]];
        
        // 正确做法
        //        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:square.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        //            [button setImage:image forState:UIControlStateNormal];
        //        }];
    }

    
}



- (void)buttonClick:(CHGSquareButton *)button
{
    
}


@end
