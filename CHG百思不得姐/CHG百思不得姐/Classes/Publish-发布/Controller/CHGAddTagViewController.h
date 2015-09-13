//
//  CHGAddTagViewController.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/12.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHGAddTagViewController : UIViewController
/** 传递tag数据的block, block的参数是一个字符串数组 */
@property (nonatomic, copy) void (^getTagsBlock)(NSArray *);
@end
