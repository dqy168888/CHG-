//
//  UIImage+CHGExtension.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/6.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CHGExtension)

/**
 * 返回一张圆形图片
 */
- (instancetype)circleImage;

/**
 * 返回一张圆形图片
 */
+ (instancetype)circleImageNamed:(NSString *)name;

@end
