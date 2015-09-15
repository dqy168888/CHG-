//
//  NSData+CHGExtension.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/15.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CHGExtension)
//- (NSDateComponents *)intervalToDate:(NSDate *)date;
//- (NSDateComponents *)intervalToNow;

/**
 * 比较from和self的时间差值（当前时间 - 发帖时间）
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

@end
