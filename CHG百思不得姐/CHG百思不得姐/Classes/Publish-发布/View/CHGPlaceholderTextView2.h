//
//  CHGPlaceholderTextView2.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/10.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHGPlaceholderTextView2 : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
