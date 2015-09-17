//
//  CHGComment.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/18.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CHGUser;
@interface CHGComment : NSObject
/** 文字内容 */
@property (nonatomic, copy) NSString *content;

/** 用户 */
@property (nonatomic, strong) CHGUser *user;
@end
