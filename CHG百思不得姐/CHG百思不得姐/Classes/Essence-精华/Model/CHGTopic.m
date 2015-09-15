//
//  CHGTopic.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/14.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGTopic.h"
/*
 一、今年
 1.今天
 1> 时间差距 < 1分钟
 * 刚刚
 
 2> 1分钟 =< 时间差距 <= 59分钟
 * xx分钟前
 
 3> 时间差距 >= 1小时
 * xx小时前
 
 2.昨天
 * 昨天 18:06:56
 
 3.其它
 * 08-07 18:06:56
 
 二、非今年
 * 2014-08-07 18:06:56
 */
@implementation CHGTopic
- (NSString *)created_at
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_created_at];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _created_at;
    }

}

@end

/*
 // NSString -> NSDate
 NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
 // 设置日期格式（解析字符串中的日期元素）
 fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
 
 // 生成2个NSDate对象，用来比较时间差值
 NSDate *createdAtDate = [fmt dateFromString:topic.created_at]; // 发帖时间
 NSDate *nowDate = [NSDate date]; // 手机当前时间
 
 // 获得createdAtDate和nowDate之间相差的秒数
 NSTimeInterval interval = [nowDate timeIntervalSinceDate:createdAtDate];
 */

/**
 服务器返回的日期
 1> 时间字符串：2015-09-13 18:13:03
 NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
 fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
 NSDate *date = [fmt dateFromString:时间字符串];
 
 2> 时间戳：5646456456546
 NSDate *date = [NSDate dateWithTimeIntervalSince1970:时间戳/1000.0];
 */

// 时间戳：从1970-1-1 00:00:00开始到现在为止走过的毫秒数