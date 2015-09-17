//
//  CHGUser.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/18.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHGUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end
