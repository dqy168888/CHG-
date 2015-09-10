//
//  UIImageView+CHGExtension.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/6.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CHGExtension)
/**
 * 根据URL下载图片并设置头像 （配合 UIImage+CHGExtension）
 */
- (void)setHeader:(NSString *)url;
@end
