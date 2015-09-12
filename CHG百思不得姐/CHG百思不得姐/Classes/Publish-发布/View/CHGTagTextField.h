//
//  CHGTagTextField.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/13.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHGTagTextField : UITextField
/** 点击删除键需要执行的操作 */
@property (nonatomic, copy) void (^deleteBackwardOperation)();
@end
