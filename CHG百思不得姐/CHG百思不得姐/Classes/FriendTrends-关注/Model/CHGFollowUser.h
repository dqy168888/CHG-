//
//  CHGFollowUser.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/21.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHGFollowUser : NSObject
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;
/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;

@end
